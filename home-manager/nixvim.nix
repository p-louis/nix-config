{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      expandtab = true;

      hlsearch = false;
      incsearch = true;

      clipboard = "unnamedplus";

      swapfile = false;
      backup = false;
      undodir = "/home/patrick/.local/share/vim/undodir";
      undofile = true;

      breakindent = true;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";

      updatetime = 50;
      timeoutlen = 300;

      completeopt = "menuone,noselect";

      termguicolors = true;

      scrolloff = 8;

      # colorcolumn = 80;
    };

    colorschemes.catppuccin.enable = true;

    plugins = {
      alpha = {
        enable = true;
        iconsEnabled = true; # installs nvim-web-devicons.
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = [
              "                 ______"
              "                /     /\\"
              "               /     /##\\"
              "              /     /####\\"
              "             /     /######\\"
              "            /     /########\\"
              "           /     /##########\\"
              "          /     /#####/\\#####\\"
              "         /     /#####/++\\#####\\"
              "        /     /#####/++++\\#####\\"
              "       /     /#####/\\+++++\\#####\\"
              "      /     /#####/  \\+++++\\#####\\"
              "     /     /#####/    \\+++++\\#####\\"
              "    /     /#####/      \\+++++\\#####\\"
              "   /     /#####/        \\+++++\\#####\\"
              "  /     /#####/__________\\+++++\\#####\\"
              " /                        \\+++++\\#####\\"
              "/__________________________\\+++++\\####/"
              "\\+++++++++++++++++++++++++++++++++\\##/"
              " \\+++++++++++++++++++++++++++++++++\\/"
              "  ``````````````````````````````````"
              ""
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                command = "<CMD>ene <CR>";
                desc = "  New file";
                shortcut = "<Leader>cn";
              }
              {
                command = ":qa<CR>";
                desc = "  Quit Neovim";
                shortcut = ":q";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = "The way out is through.";
          }
        ];
      };

      lsp.enable = true;

      fugitive.enable = true;
      surround.enable = true;
      undotree.enable = true;

      treesitter = {
        enable = true;
        ensureInstalled = [
          "rust"
          "elm"
          "go"
          "gitcommit"
          "gitignore"
          "git_config"
          "git_rebase"
          "kotlin"
          "norg"
          "nix"
        ];
      };
      which-key.enable = true;
      rust-tools.enable = true;
      nix.enable = true;

    #cmp.enable = true;
    #cmp-nvim-lsp.enable = true;
    #friendly-snippets.enable = true;

    lualine = {
      enable = true;
      iconsEnabled = false;
      theme = "catppuccin";
      componentSeparators = {
        left = "";
        right = "";
      };
      sectionSeparators = {
        left = "";
        right = "";
      };
    };

    telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-nix
    nvim-cmp
    cmp-nvim-lsp
    nvim-lspconfig
    mason-nvim
    mason-lspconfig-nvim
    friendly-snippets
    neodev-nvim
    luasnip
    fidget-nvim
  ];

  keymaps = [
    { 
      mode ="n";
      key = "<leader>pv";
      action = ":Ex<CR>";
      options = { desc = "NetRW"; };
    }

    { 
      mode ="v";
      key = "J";
      action = ":m \">+1<CR>gv=gv";
      options = { desc = "Move selection down"; };
    }
    { 
      mode ="v";
      key = "K";
      action = ":m \"<-2<CR>gv=gv";
      options = { desc = "Move selection down"; };
    }

    { 
      mode =[ 
        "n"
        "v" ];
        key = "<Space>";
        action = "<Nop>"; 
        options = { silent = true; };
      }

      { 
        mode ="n";
        key = "k";
        action = "v:count == 0 ? \"gk\" : \"k\"";
        options = { 
          expr = true;
          silent = true; 
        };
      }
      { 
        mode ="n";
        key = "j";
        action = "v:count == 0 ? \"gj\" : \"j\"";
        options = {
          expr = true; 
          silent = true;
        };
      }

      {
        mode ="n";
        key = "<leader>.";
        action = "<cmd>bn<CR>";
        options = { desc = "Next Buffer"; };
      }
      { 
        mode ="n";
        key = "<tab>";
        action = "<cmd>bn<CR>";
        options = { desc = "Next Buffer"; };
      }
      { 
        mode ="n";
        key = "<S-tab>";
        action = "<cmd>bp<CR>";
        options = { desc = "Previous Buffer"; };
      }
      { 
        mode ="n";
        key = "<leader>bd";
        action = "<cmd>bd<CR>";
        options = { desc = "Delete Buffer"; };
      }

      {
        mode ="n";
        key = "[d";
        action = "vim.diagnostic.goto_prev";
        options = { desc = "Go to previous diagnostic message"; };
      }
      { 
        mode ="n";
        key = "]d";
        action = "vim.diagnostic.goto_next";
        options = { desc = "Go to next diagnostic message"; };
      }
      { 
        mode ="n";
        key = "<leader>e";
        action = "vim.diagnostic.open_float";
        options = { desc = "Open floating diagnostic message"; };
      }
      { 
        mode ="n";
        key = "<leader>q";
        action = "vim.diagnostic.setloclist";
        options = { desc = "Open diagnostics list"; };
      }

      { 
        mode ="n";
        key = "<leader>crf";
        action = "vim.lsp.codelens.refresh";
        options = { desc = "[C]odelens [R]e[f]resh"; };
      }
      { 
        mode ="n";
        key = "<leader>cr";
        action = "vim.lsp.codelens.run";
        options = { desc = "[C]odelens [R]un"; };
      }
      { 
        mode ="n";
        key = "<leader>ca";
        action = "vim.lsp.buf.code_action";
        options = { desc = "[C]odelens [R]un"; };
      }
      { 
        mode ="n";
        key = "<leader>ra";
        action = "vim.lsp.buf.rename";
        options = { desc = "[R]ename [A]ll"; };
      }

      { 
        mode ="x";
        key = "<leader>p";
        action = "\"_dP";
        options = { desc = "Paste and keep copied text"; };
      }

      { 
        mode ="n";
        key = "<leader>y";
        action = "\"+y";
        options = { desc = "Yank into system clipboard"; };
      }
      { 
        mode ="v";
        key = "<leader>y";
        action = "\"+y";
        options = { desc = "Yank into system clipboard"; };
      }
      { 
        mode ="v";
        key = "<leader>Y";
        action = "\"+Y";
        options = { desc = "Yank into system clipboard"; };
      }
      { 
        mode ="n";
        key = "<leader>p";
        action = "\"+p";
        options = { desc = "Paste from system clipboard"; };
      }
      { 
        mode ="n";
        key = "<leader>P";
        action = "\"+P";
        options = { desc = "Paste from system clipboard"; };
      }

      { 
        mode ="n";
        key = "<leader>s";
        action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
      }

      { 
        mode ="n";
        key = "<leader>gs";
        action = ":Git<CR>";
        options = { desc = "[G]it [S]tatus"; };
      }
      { 
        mode ="n";
        key = "<leader>gp";
        action = ":Git push -u origin";
        options = { desc = "[G]it [P]ush"; };
      }
      { 
        mode ="n";
        key = "gt";
        action = "<cmd>diffget //2<CR>";
        options = { desc = "Get left change"; };
      }
      { 
        mode ="n";
        key = "gn";
        action = "<cmd>diffget //3<CR>";
        options = { desc = "Get right change"; };
      }
    ];

    extraConfigLuaPost = ''
   -- [[ Configure LSP ]]
   --  This function gets run when an LSP connects to a particular buffer.
   local on_attach = function(_, bufnr)
     -- NOTE: Remember that lua is a real programming language, and as such it is possible
     -- to define small helper and utility functions so you don't have to repeat yourself
     -- many times.
     --
     -- In this case, we create a function that lets us more easily define mappings specific
     -- for LSP related items. It sets the mode, buffer and description for us each time.
     local nmap = function(keys, func, desc)
       if desc then
         desc = 'LSP: ' .. desc
       end

       vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
     end

     nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
     nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

     nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
     nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
     nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
     nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
     nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
     nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

     -- See `:help K` for why this keymap
     nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
     nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

     -- Lesser used LSP functionality
     nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
     nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
     nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
     nmap('<leader>wl', function()
       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
     end, '[W]orkspace [L]ist Folders')

     -- Create a command `:Format` local to the LSP buffer
     vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
       vim.lsp.buf.format()
     end, { desc = 'Format current buffer with LSP' })
   end

   -- Enable the following language servers
   --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
   --
   --  Add any additional override configuration in the following tables. They will be passed to
   --  the `settings` field of the server config. You must look up that documentation yourself.
   --
   --  If you want to override the default filetypes that your language server will attach to you can
   --  define the property 'filetypes' to the map in question.
   local servers = {
     -- clangd = {},
     gopls = {},
     -- pyright = {},
     rust_analyzer = {},
     -- tsserver = {},
     -- html = { filetypes = { 'html', 'twig', 'hbs' } },

     lua_ls = {
       Lua = {
         workspace = { checkThirdParty = false },
         telemetry = { enable = false },
       },
     },
   }

   -- Setup neovim lua configuration
   require('neodev').setup()
   require('mason').setup()

   -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
   local capabilities = vim.lsp.protocol.make_client_capabilities()
   capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

   -- Ensure the servers above are installed
   local mason_lspconfig = require 'mason-lspconfig'

   mason_lspconfig.setup {
     ensure_installed = vim.tbl_keys(servers),
   }

   mason_lspconfig.setup_handlers {
     function(server_name)
       require('lspconfig')[server_name].setup {
         capabilities = capabilities,
         on_attach = on_attach,
         settings = servers[server_name],
         filetypes = (servers[server_name] or {}).filetypes,
       }
     end
   }

   -- [[ Configure nvim-cmp ]]
   -- See `:help cmp`
   local cmp = require 'cmp'
   local luasnip = require 'luasnip'
   require('luasnip.loaders.from_vscode').lazy_load()
   luasnip.config.setup {}

   ---@diagnostic disable-next-line: missing-fields
   cmp.setup {
     snippet = {
       expand = function(args)
         luasnip.lsp_expand(args.body)
       end,
     },
     mapping = cmp.mapping.preset.insert {
       ['<C-n>'] = cmp.mapping.select_next_item(),
       ['<C-p>'] = cmp.mapping.select_prev_item(),
       ['<C-d>'] = cmp.mapping.scroll_docs(-4),
       ['<C-f>'] = cmp.mapping.scroll_docs(4),
       ['<C-Space>'] = cmp.mapping.complete {},
       ['<CR>'] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
       },
       ['<Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
           cmp.select_next_item()
         elseif luasnip.expand_or_locally_jumpable() then
           luasnip.expand_or_jump()
         else
           fallback()
         end
       end, { 'i', 's' }),
       ['<S-Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
           cmp.select_prev_item()
         elseif luasnip.locally_jumpable(-1) then
           luasnip.jump(-1)
         else
           fallback()
         end
       end, { 'i', 's' }),
     },
     sources = {
       { name = 'nvim_lsp' },
       { name = 'luasnip' },
     },
   }
    '';
  };
}
