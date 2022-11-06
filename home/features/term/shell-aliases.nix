{ 
    config
    , pkgs
    , programs
    ,... 
}:
{
    home.shellAliases = with pkgs;{
    # Nix
    nfmt = "nixpkgs-fmt .";
    ns = "nix-shell";
    nsp = "nix-shell --pure";
    
    # My tools
    calc_latency="_calc_latency"; ## Compute approximatively internet latency
    update_nix_index="_update_nix_index"; ## update nix-index database from https://github.com/Mic92/nix-index-database project
    toclipboard="${xclip} -selection clipboard"; ## Copy output to clipboard
    get_i3_window_name="${xorg.xprop} | grep CLASS";

    # Tools
    calc="eva"; ## launch calc computing (eva)
    fd="fd"; ## find files alternative (fd)
    pup="up"; ## pipe output (we can run linux command in realtime)
    diga="dog A CNAME MX TXT AAAA NS"; ## dig DNS resolution alternative (dog)
    dig="dog A"; ## dig DNS resolution alternative (dog)
    hexyl="hexyl --border none"; ## hexdump alternative
    #br="broot"; ## File manager        

    # ZSH
    my-zkeys="cat $HOME/.config/zsh/.zprofile | grep -Eo '# \[.*' | sed 's/# //g'";

    # ps & top  alternative
    psc="procs --sortd cpu";
    psm="procs --sortd mem";
    psr="procs --sortd read";
    psw="procs --sortd write";

    topc="procs -W 1 --sortd cpu";
    topm="procs -W 1 --sortd mem";
    topr="procs -W 1 --sortd read";
    topw="procs -W 1 --sortd write";

    # Disk size
    dua="dua i"; ## | Interactive disk size(dua)
    dut="dust"; ## | Show tree disk size (ordered by big file) (dust)

    # SSH
    sk="sh -o StrictHostKeyChecking=no"; ## ssh without host verification        

    # cat alternative
    cat="${bat} --style=plain"; ## cat alternative (bat)

    # ls alternative
    la="exa --color=always -a";
    ll="exa --color=always -alh";
    ls="exa --color=always";

    # Folder
    ".."="cd ..";
    "..."="cd ../..";
    "...."="cd ../../..";
    cdw="cd ${config.home.sessionVariables.WORK}"; ## goto working project folder
    cdp="cd ${config.home.sessionVariables.PRIVATE}"; ## goto private project folder

    # git
    gs="git status"; ## git status
    gl="git log"; ## git log
    gd="git diff"; ## git diff
    gds="git diff --staged"; ## git diff
    gcb="git checkout";
    gbl="git branch"; ## git branch
    gbm="git blame"; ## git blame
    ga="git add"; ## git add
    gc="git commit -m"; ## git commit
    gss="git stash"; ## git stash
    gsl="git stash list"; ## git stash list
    gsp="git stash pop"; ## git stash pop
    gpl="git pull"; ## git pull
    gph="git push"; ## git push

    # yadm
    ys="yadm status"; ## yadm status
    yl="yadm log"; ## yadm log
    yd="yadm diff"; ## yadm diff
    yds="yadm diff --staged"; ## yadm diff
    ybl="yadm branch"; ## yadm branch
    ybm="yadm blame"; ## yadm blame
    ya="yadm add"; ## yadm add
    yc="yadm commit -m"; ## yadm commit
    ypl="yadm pull"; ## yadm pull
    yph="yadm push"; ## yadm push

    # pass
    pps="pass git status"; ## pass status
    pl="pass git log"; ## pass log
    pd="pass git diff"; ## pass diff
    pds="pass git diff"; ## pass diff
    pbl="pass git branch"; ## pass branch
    pbm="pass git blame"; ## pass blame
    pa="pass git add"; ## pass add
    pc="pass git commit -m"; ## pass commit
    ppl="pass git pull"; ## pass pull
    pph="pass git push"; ## pass push

    # Trash
    # rm="${trash-put}"; ## alternative rm (push file to trash)
    # trm="${trash-put}"; ## push file to trash
    # tls="${trash-list}"; ## list trash files
    # tre="${trash-restore}"; ## restore file from trash
    # tem="${trash-empty}"; ## delete all files from trash

    # Cloud & co
    #unalias kubectl # Disable clourify for using P10K plugin
    a="aws"; ## aws alias
    g="gcloud"; ## gcloud alias
    k="kubectl"; ## kubectl alias
    kcc="kubectl config current-context";
    h="helm"; ## helm alias

    vim="neovim"; ## alternative vim (nvim)

    # navi
    lnavi="navi --path $PRIVATE/cheats"; ## Show cheat commands
    lpnavi="navi --print --path $PRIVATE/cheats"; ## Show cheat commands

    # Date & Time
    clock="peaclock --config-dir ~/.config/peaclock"; ## Show terminal clock

    # Color
    grep="grep --color=auto";
    ip="ip -color=auto";
    };
}