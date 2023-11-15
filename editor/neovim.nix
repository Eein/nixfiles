# https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509 
{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withAllGrammars)
      catppuccin-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      nvim-lspconfig
      elixir-tools-nvim
      indent-o-matic
      neomake
      neoformat
      vim-surround
      vim-repeat
      vim-endwise
      vim-commentary
      # vim-buftabline (this doesnt exist yet)
      vim-rhubarb
      vim-fugitive
      vim-floaterm
      vim-move
      vim-bbye
      telescope-nvim
      vim-visual-multi
      lf-vim
      gitsigns-nvim
    ];
    extraPackages = with pkgs;
    [
      ripgrep 
      git 
      fd
      fzf
      ghc
      stack
      cabal-install
    ];
    extraConfig = ''
      lua << EOF
      vim.cmd("colorscheme catppuccin-mocha")
      vim.opt.backupcopy = "yes"
      vim.opt.filetype = "off"
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      vim.opt.hlsearch = true
      vim.opt.mouse = ""
      vim.opt.number = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.autoread = true
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.background = "dark"
      vim.opt.termguicolors = true

      vim.cmd([[
        cnoreabbrev E Lf
        set wildignorecase
        set wildmode=list:longest
        set wildmenu
        set wildignore=*.o,*.obj,*~
        set wildignore+=*vim/backups*
        set wildignore+=*sass-cache*
        set wildignore+=*DS_Store*
        set wildignore+=*node_modules*
        set wildignore+=vendor/rails/**
        set wildignore+=vendor/cache/**
        set wildignore+=*.gem
        set wildignore+=log/**
        set wildignore+=_build/**
        set wildignore+=deps/**
        set wildignore+=tmp/**
        set wildignore+=*/.git/*,*/tmp/*,*.swp
        set wildignore+=*.cache
        set wildignore+=*.png,*.jpg,*.gif
      ]])

      local opts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap("i", "jj", "<Esc>", opts)
      vim.api.nvim_set_keymap("n", "0", "^", opts)
      vim.api.nvim_set_keymap("n", "-", "<Nop>", opts)
      vim.api.nvim_set_keymap("n", "<leader>b", ":BufOnly<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)

      -- Normal-mode commands
      vim.keymap.set("n", "<C-j>", ":MoveLine(1)<CR>", opts)
      vim.keymap.set("n", "<C-k>", ":MoveLine(-1)<CR>", opts)

      vim.keymap.set("n", "<C-h>", ":bprev<CR>", opts)
      vim.keymap.set("n", "<C-l>", ":bnext<CR>", opts)
      vim.keymap.set("n", "<C-p>", ":FZF<CR>", opts)

      -- Visual-mode commands
      vim.keymap.set("v", "<C-j>", ":MoveBlock(1)<CR>", opts)
      vim.keymap.set("v", "<C-k>", ":MoveBlock(-1)<CR>", opts)

      if vim.fn.executable("rg") == 1 then
        vim.cmd([[
          set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
          let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
        ]])
      end

      vim.cmd([[
        let g:move_key_modifier = 'C'
      ]])

      -- vim.cmd([[
      --   autocmd BufRead,BufNewFile *.{exs} setlocal filetype=elixir
      -- ]])

      -- vim.cmd([[
      --   autocmd BufRead,BufNewFile *.{exs} setlocal filetype=elixir
      -- ]])

      -- vim.cmd([[
      --   let test#strategy = "tslime"
      --   nmap <silent> <leader>t :TestNearest<CR>
      --   nmap <silent> <leader>T :TestFile<CR>
      -- ]])

      vim.cmd([[
        :command Grepper Telescope live_grep
      ]])

      vim.cmd([[
        let g:lf_replace_netrw = 1
        let g:lf_map_keys = 0
        let g:floaterm_opener = "edit"

        let g:floaterm_width = 0.9
        let g:floaterm_height = 0.95
        let g:floaterm_position = 'center'
      ]])

      -- Auto formatting
      vim.cmd([[
        augroup fmt
          autocmd!
          autocmd BufWritePre * try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
        augroup END
      ]])

      require("telescope").setup({
        pickers = {
          find_files = { theme = "dropdown" },
          live_grep = { theme = "dropdown" },
        },
      })
      EOF
    '';
  };
}
