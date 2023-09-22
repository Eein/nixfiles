# https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509 
{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      elixir-tools-nvim
      (nvim-treesitter.withPlugins (ps: with ps; [ nix rust ]))
      {
        plugin = lf-vim;
        config = ''
	  if executable('lf') == 1 
	    cabbrev E Lf
	    let g:lf_replace_netrw = 1
	    let g:lf_map_keys = 0
	    let g:floaterm_opener = "edit"
	    let g:floaterm_width = 0.9
	    let g:floaterm_height = 0.95
	    let g:floaterm_position = "center"
	  endif
        '';
      }
      catppuccin-nvim
      indent-o-matic
      vim-floaterm
    ];
  };
}
