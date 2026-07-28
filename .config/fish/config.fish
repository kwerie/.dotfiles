# ─── Environment ───────────────────────────────────────────────
set -gx EDITOR nvim
set -gx KUBE_EDITOR nvim
set -gx COLORTERM truecolor
set -gx TERMINAL /usr/bin/wezterm
set -gx LIBVIRT_DEFAULT_URI 'qemu:///system'
set -gx XCURSOR_PATH /run/host/share/icons:/run/host/user-share/icons:/usr/share/icons
set -gx XCURSOR_THEME breeze_cursors

# ─── PATH (idempotent; prepends and dedupes) ───────────────────
fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.bash/bin
fish_add_path -g $HOME/.dotnet/tools
fish_add_path -g $HOME/.nimble/bin
fish_add_path -g $HOME/.bun/bin
fish_add_path -g /usr/local/go/bin
fish_add_path -g $HOME/.local/share/JetBrains/Toolbox/scripts

# ─── fnm (Node version manager) ────────────────────────────────
set -gx FNM_PATH $HOME/.local/share/fnm
if test -d $FNM_PATH
    fish_add_path -g $FNM_PATH
    $FNM_PATH/fnm env --use-on-cd --shell fish | source
end

# ─── Secrets (real file lives only in ~/.config/fish, never in .dotfiles) ───
if test -f $__fish_config_dir/secrets.fish
    source $__fish_config_dir/secrets.fish
end

# ─── Interactive-only ──────────────────────────────────────────
if status is-interactive
    set -gx GPG_TTY (tty)

    # Load all .fish files in ./aliases
    set config_dir (dirname (status filename))
    set aliases_dir $config_dir/aliases

    for file in $aliases_dir/*.fish
        source $file
    end
end
