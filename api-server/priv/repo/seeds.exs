# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApiServer.Repo.insert!(%ApiServer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ApiServer.Repo
alias ApiServer.UserContext.User
alias ApiServer.VipCardContext.VipCard

 
%User{
  wechat_openid: "19820325",
  wechat_nickname: "link",
  mobile: "15156709660"
}
|> Repo.insert

%User{
  wechat_openid: "19831022",
  wechat_nickname: "lulu",
  mobile: "15156709660"
}
|> Repo.insert

%VipCard{
  name: "女人卡",
  level: 1,
  price: 800.00,
  value: 1000.00,
  swim_price: 65.00
}
|> Repo.insert

%VipCard{
  name: "女王卡",
  level: 2,
  price: 3800.00,
  value: 5000.00,
  swim_price: 65.00
}
|> Repo.insert

%VipCard{
  name: "女神卡",
  level: 3,
  price: 8000.00,
  value: 10000.00,
  swim_price: 0.00
}
|> Repo.insert




