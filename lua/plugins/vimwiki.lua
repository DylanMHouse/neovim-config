return {
  'vimwiki/vimwiki',
  init = function()
    -- must be set before vimwiki loads
    vim.g.vimwiki_list = {
      {
        path = '~/documents/wiki',
        path_html = '~/documents/wiki_html',
      },
    }
  end,
}
