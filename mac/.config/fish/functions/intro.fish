function intro --description 'ターミナルのオープニング演出'
    set -l name $argv[1]
    test -z "$name"; and set name banner

    switch $name
        case banner
            clear
            figlet (whoami) | lolcat
            echo
            fastfetch --pipe false | tte (random choice decrypt beams slide wipe rain)
        case quick
            figlet (whoami) | lolcat
            fastfetch
        case matrix
            cmatrix -C blue -b
        case pipes
            pipes.sh
        case bonsai
            cbonsai -l
        case aquarium
            asciiquarium
        case clock
            tty-clock -c -s -C 4
        case random
            intro (random choice matrix pipes bonsai aquarium clock)
        case list
            echo "banner  quick  matrix  pipes  bonsai  aquarium  clock  random"
        case '*'
            echo "使い方: intro [banner|quick|matrix|pipes|bonsai|aquarium|clock|random|list]"
    end
end
