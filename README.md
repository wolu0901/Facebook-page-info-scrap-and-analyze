# Facebook-page-info-scrap-and-analyze
首先开一个账户，网上有人说新卡一个账户什么的，我新开了一个账户只用来爬数据，三天两头被Facebook封掉。。。所以干脆就用我自己的账户算了。
流程：
1.	开一个app。链接：https://developers.facebook.com/apps/ 注册成为开发者。然后随便起一个喜欢的app名字。
2.	不用做任何setting，进入setting-basic, 应该可以看到app id 和app secret。
3.	开始用graph api。链接：https://developers.facebook.com/tools/explorer 这里在右上角一定要记住Application 这里选择自己的app，而不是Graph Api Explorer， 否则是成功不了的。
4.	这里想选什么token在get token里面选择，就可以生成了。因为我这里只要page 的内容，不需要用户的数据，所以选哪一个都可以。
5.	生成access token以后可以先尝试一下。https://graph.facebook.com/v2.9/tesla/posts/?access_token=YOURACCESSTOKEN&since=2017-01-01&until=2017-12-31&fields=message 把生成的access token 复制到url里面然后用浏览器打开试试看。结果应该是tesla页面2017年的所有message。
6.	不过这里的access token是临时的，可以进https://developers.facebook.com/tools/debug/accesstoken/ 查看剩余时间
7.	为了方便，我们可以生成一个两个月的access token。https://graph.facebook.com/oauth/access_token?client_id=APP_ID_HERE&client_secret=APP_SECRET_HERE&grant_type=fb_exchange_token&fb_exchange_token=ACCESS_TOKEN_HERE 
8.	把前面流程2看到的App id， app secret 和临时token输入url，就可以获得长期的token了。
9.	用新的token回到步骤6，可以看到两个月啦~~~ 
