library("plyr")
library("ggplot2")
library("XML")
library("gridExtra")

theurl = "http://gureckislab.org/blog/?p=4098"
tables = readHTMLTable(theurl)

tables = llply(tables, function(df){df$answer = sub("\u2026", "...", sub("\u2019", "'", as.character(df$V1)));
                                    df$count = as.numeric(as.character(df$V2));
                                    df$percent = as.numeric(sub("%", "", as.character(df$V3)));
                                    df[, c("answer", "count", "percent")]})


challenges = tables[[2]]
features = tables[[8]]
features$answer=sub("\u00A0", " ", as.character(features$answer))
features$psiTurk = c(1,1,0,1,1,1,0,1,1,1,0,1,2,2,2,0,0,1,0)

## data.frame(answers = c("Data is unreliable", "Experiment designs I'm interested\nin do not work well online",
##              "Population is unrepresentative", "The technology required\nis too complex",
##              "I cannot get IRB approval\nto do online studies",
##              "I am based outside the US and\nfind it difficult to use services\nlike Amazon Mechanical Turk",
##              "Other"),
##     count = c(70, 100, 51, 53, 3, 46, 35),
##     percent = c(35, 50, 25, 26, 1, 23, 17))
## challenges$answers = factor(challenges$answers, rev(as.character(challenges$answers)))


pdf(file="figures/challenges.pdf", width = 7, height = 4, useDingbats = FALSE)

ggplot(challenges, aes(answer, percent)) + geom_bar() + coord_flip() + theme_classic() + xlab("") + ylab("Percent reporting challenge")

dev.off()

pdf(file="figures/features.pdf", width = 15, height = 6, useDingbats = FALSE)
grid.table(features[,c("answer", "percent", "psiTurk")])
dev.off()
