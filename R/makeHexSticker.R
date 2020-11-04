library(ggplot2)
library(hexSticker)
library(darkpeak)
p <- ggplot(aes(x = mpg, y = wt), 
            data = mtcars) + 
  geom_point()
p <- p + theme_void() + theme_transparent()

sticker(p, package="hexSticker", filename="hexSticker.png")


sticker(subplot = p,
        package="heRvis",s_x = 1,s_y = 1,
        filename="hexSticker.png")

p <- makeCEPlane(treatment = c("treat 5")) + theme_void() + theme_transparent()

df =  as.data.frame(cbind(example_TQ,example_TC))
colnames(df)[1:6] <- paste0("QALY",1:6)
colnames(df)[7:12] <- paste0("COST",1:6)
df <- head(df,1000)
df$incQALY = df$QALY1- df$QALY6
df$incCOST = df$COST1 - df$COST6

p = ggplot(data = df,
  aes(x = QALY1 - QALY6, 
      y = COST1 - COST6)
  ) + geom_point()+ theme_void() + theme_transparent()