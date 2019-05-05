defmodule ApiServerWeb.TranslateMsg do
  require ApiServerWeb.Gettext

  def translate_msg(s) do
    Gettext.gettext(ApiServerWeb.Gettext, s)
  end

  def sigil_t(string, []), do: Gettext.gettext(ApiServerWeb.Gettext, string)
end