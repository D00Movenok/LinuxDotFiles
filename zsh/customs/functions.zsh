# fzf selector from available wordlists
# first arg is a search query
fzf-wordlists() {
    local wordlist_path=(
        $(locate -b -i seclists | grep -i '/seclists$')
        "/usr/share/wordlists"
    )

    # find all wordlists excluding hidden and markdown files
    local all_wordlists=$(
        find "${wordlist_path[@]}" -type f \
        -not -path '*/.*' \
        -not -name '*.md' \
        2>/dev/null
    )

    local selected_wordlist=$(
        echo "$all_wordlists" | \
        fzf --header "Select wordlist:" --reverse --height=~30% -e --preview 'head -n 50 {}' -q "$1"
    )

    echo "$selected_wordlist"
}

# ffuf commands preset
# first arg is url, second is query for wordlists search
auto-ffuf() {
    local url="${1:-example.com}"
    local wordlist="$(fzf-wordlists $2)"

    local default_cmd="ffuf -H \\\"User-Agent: \\\$(random-ua)\\\" -w '\$wordlist' -ic -sf -c -r -t 10 -u"
    local ffuf_commands=(
        "$default_cmd '$url/FUZZ'" # path fuzzing
        "$default_cmd '$url/' -H 'Host: FUZZ.$url'" # vhost fuzzing
        "$default_cmd 'FUZZ.$url/'" # subdomain fuzzing when wildcard dns
    )

    local cmd=$(
        printf "%s\n" "${ffuf_commands[@]}" | \
        fzf --header "Select ffuf command:" --reverse --height=~30% -e --keep-right
    )

    print -z $(eval "echo \"$cmd\"")
}

# generate random windows useragent with Chrome version > 110
# requires projectdiscovery/useragent
random-ua() {
    local MIN_CHROME_VERSION=110
    local UA=""

    # projectdiscovery/useragent randoms useragents, so we need tries to found newer versions
    local tries=0
    local max_tries=10
    while [[ -z "$UA" && $tries -lt $max_tries ]]; do
        UA=$(
            $HOME/go/bin/ua -t chrome -l -1 | \
            grep "Windows NT" | \
            awk -F "Chrome/" "{if (NF>1) {split(\$2,a,\".\"); if (a[1]>$MIN_CHROME_VERSION) print \$0}}"
        )
        tries=$((tries + 1))
    done

    if [[ -z "$UA" ]]; then
        echo "No suitable user agent found in $max_tries attempts."
        return 1
    fi

    echo "$UA" | shuf -n 1
}

# System
update-system() {
    echo "Updating system packages..."
    sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove && sudo apt clean

    echo "Updating snap packages..."
    sudo snap refresh

    if command -v pipx >/dev/null 2>&1; then
        echo "Updating pipx packages..."
        pipx upgrade-all
    fi

    if command -v gup >/dev/null 2>&1; then
        echo "Updating go packages..."
        # -j 2 bypasses golang proxy time limits
        gup update -j 2
    fi

    if command -v asdf >/dev/null 2>&1; then
        echo "Updating asdf plugins..."
        asdf plugin update --all
    fi

    if command -v rustup >/dev/null 2>&1; then
        echo "Updating rust..."
        rustup update
    fi
}
