library(ggplot2)
library(hexSticker)
library(darkpeak)

df = data.frame(Q = runif(n = 100,min = 2,max = 4), 
                C = runif(n = 100,min = 20000,max = 60000))


p <- ggplot(aes(x = Q, y = C), 
            data = df) + 
  geom_point(size = 0.25,col = "magenta") + 
   theme_transparent() +
   theme_void() + 
   xlim(c(-abs(max(df$Q*1.4)/2),max(df$Q*1.4))) + 
   ylim(c(-abs(max(df$C*1.4)/2),max(df$C*1.4))) + 
   stat_ellipse(col = "magenta") + 
   geom_hline(yintercept = 0)+
   geom_vline(xintercept = 0) + 
   geom_abline(intercept = 0,
               slope = 20000,
               linetype = "dashed")
 


sticker(p, package="heRvis", filename="www/hexSticker.png",
        p_y = 1.4, p_size=13, p_color = "magenta",
        h_fill = "grey90",h_color = "magenta",
        s_x=1.13, s_y=0.8, 
        s_width=1, s_height=1)


#sticker(subplot = p,
#        package="heRvis",s_x = 1,s_y = 1,
#        filename="hexSticker.png")
#
#p <- makeCEPlane(treatment = c("treat 5")) + theme_void() + theme_transparent()
#
#df =  as.data.frame(cbind(example_TQ,example_TC))
#colnames(df)[1:6] <- paste0("QALY",1:6)
#colnames(df)[7:12] <- paste0("COST",1:6)
#df <- head(df,1000)
#df$incQALY = df$QALY1- df$QALY6
#df$incCOST = df$COST1 - df$COST6
#
#p = ggplot(data = df,
#  aes(x = QALY1 - QALY6, 
#      y = COST1 - COST6)
#  ) + geom_point()+ theme_void() + theme_transparent()
#
#sticker(~plot(df, cex=.5, cex.axis=.5, mgp=c(0,.3,0),xmin = 0,xmax = 5,ymin = 0,ymax = 70000, xlab="", ylab=""),
#        package="heRvis", p_size=20, s_x=.8, s_y=.6, s_width=1.4, s_height=1.2,
#        filename="deprecated/sticker.png")
