# https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509 
{ pkgs, ... }:
let
  vim-buftabline = pkgs.vimUtils.buildVimPlugin {
    name = "vim-buftabline";
    src = pkgs.fetchFromGitHub {
      owner = "ap";
      repo = "vim-buftabline";
      rev = "73b9ef5dcb6cdf6488bc88adb382f20bc3e3262a";
      hash = "sha256-vmznVGpM1QhkXpRHg0mEweolvCA9nAOuALGN5U6dRO8=";
    };
  };
  movedotnvim = pkgs.vimUtils.buildVimPlugin {
    name = "move.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "fedepujol";
      repo = "move.nvim";
      rev = "d663b74b4e38f257aae757541c9076b8047844d6";
      hash = "sha256-t1JxAwFZb2IceaVfxgg1JeXYDVmPOFjSr2RMa+BoS1s=";
    };
  };

  # outputpanel = pkgs.vimUtils.buildVimPlugin {
  #   name = "output-panel.nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mhanberg";
  #     repo = "output-panel.nvim";
  #     rev = "65bb44a5d5dbd40f3793a8c591b65a0c5f260bd9";
  #     hash = "sha256-Gm03u8PidPQ/cNkl6K5rynZiux12lqgv0E5RXItw8nI=";
  #   };
  # };

  tslime = pkgs.vimUtils.buildVimPlugin {
    name = "tslime-vim";
    src = pkgs.fetchFromGitHub {
      owner = "Eein";
      repo = "tslime.vim";
      rev = "f457a25dbd1106cf5e94b39bb0f0a84279ef5477";
      hash = "sha256-FwVakc53H4VRFKoWeq8iCwoXjbn/sX0Q1oEnz7UTlIM=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      rustaceanvim
      nvim-treesitter.withAllGrammars
      catppuccin-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      nvim-lspconfig
      indent-o-matic
      neomake
      trouble-nvim
      neoformat
      vim-test
      tslime
      vim-surround
      vim-repeat
      vim-endwise
      vim-commentary
      vim-buftabline
      vim-rhubarb
      vim-fugitive
      vim-floaterm
      movedotnvim
      vim-sleuth
      vim-bbye
      telescope-nvim
      vim-visual-multi
      lf-vim
      gitsigns-nvim
      fzf-vim
      typescript-tools-nvim
    ];
    extraPackages = with pkgs;
    [
      ripgrep 
      git 
      fd
      fzf
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
      vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>b", ":%bd|e#<CR>", opts)

      -- Normal-mode commands
      vim.keymap.set("n", "<C-j>", ":MoveLine(1)<CR>", opts)
      vim.keymap.set("n", "<C-k>", ":MoveLine(-1)<CR>", opts)

      vim.keymap.set("n", "<C-h>", ":bprev<CR>", opts)
      vim.keymap.set("n", "<C-l>", ":bnext<CR>", opts)
      vim.keymap.set("n", "<C-p>", ":FZF<CR>", opts)

      -- Visual-mode commands
      vim.keymap.set("v", "<C-j>", ":MoveBlock(1)<CR>", opts)
      vim.keymap.set("v", "<C-k>", ":MoveBlock(-1)<CR>", opts)

      vim.cmd([[
        set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
        let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
      ]])

      vim.cmd([[
        let g:move_key_modifier = 'C'
      ]])

      vim.cmd([[
        :command Grepper Telescope live_grep
      ]])

      -- Do not add this - as it breaks link propogation when using :GBrowse or
      -- shift-click
      -- let g:lf_replace_netrw = 1

      vim.cmd([[
        let g:lf_map_keys = 0
        let g:floaterm_opener = "edit"

        let g:floaterm_width = 0.9
        let g:floaterm_height = 0.95
        let g:floaterm_position = 'center'

        let g:tslime = {}
        let g:tslime['session'] = str2nr(system('tmux display-message -p "#S"'))
        let g:tslime['window'] = 1
        let g:tslime['pane'] = 2
        let g:tslime_pre_command = "C-c"
        let test#strategy = "tslime"
        nnoremap <silent> <Leader>t :w<CR> :TestFile<CR>
        nnoremap <silent> <Leader>s :w<CR> :TestNearest<CR>
        nnoremap <silent> <Leader>l :w<CR> :TestLast<CR>
      ]])

      require'nvim-treesitter.configs'.setup {
        indent = {
          enable = true
        },
        highlight = {
          enable = true
        }
      }

      require('gitsigns').setup()
      -- require("output_panel").setup()
      require("telescope").setup({
        pickers = {
          find_files = { theme = "dropdown" },
          live_grep = { theme = "dropdown" },
        },
      })

      -- LSP + nvim-cmp setup
      local lspc = require('lspconfig')
      lspc.hls.setup {}
      local cmp = require("cmp")
      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = 'buffer' },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end
        },
        mapping = {
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        },
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('trouble').setup {
        icons = false,
        use_diagnostic_signs = true,
      }

      require('lspconfig').ruff_lsp.setup {
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          }
        }
      }

      require('lspconfig')['astro'].setup({})
      require('lspconfig')['zls'].setup({})
      require('lspconfig')['nil_ls'].setup {
        capabilities = capabilities
      }

      require("typescript-tools").setup {
      }

      -- Map LSP keybindings
      -- vim.api.nvim_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
      vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>=", ":lua vim.lsp.buf.formatting()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>ah", ":lua vim.lsp.buf.hover()<CR>", opts)

      -- map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
      -- map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
      -- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
      -- map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
      -- map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
      -- map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
      -- map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
      -- map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
      -- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
      -- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
      -- map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
      -- map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
      -- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
      -- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

      EOF
    '';
  };
}
