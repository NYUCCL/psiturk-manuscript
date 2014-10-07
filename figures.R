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
challenges$label = 'challenges'
challenges = challenges[order(challenges$percent),]
uses = tables[[5]]
uses$label = 'uses'
uses = uses[order(uses$percent),]
benefits = tables[[3]]
benefits$label = 'benefits'
benefits = benefits[order(benefits$percent),]
combinedquestions = rbind(benefits, challenges, uses)

combinedquestions = combinedquestions[combinedquestions$answer!="Other",]
combinedquestions$answer = factor(combinedquestions$answer, levels=as.character(combinedquestions$answer))


features = tables[[8]]
features$answer=sub("\u00A0", " ", as.character(features$answer))
features$psiTurk = c(1,1,0,1,1,1,0,1,1,1,0,1,2,2,2,0,0,1,0)


pdf(file="figures/combinedquestions.pdf", width = 10, height = 10, useDingbats = FALSE)
ggplot(combinedquestions, aes(answer, percent, fill=label)) + geom_bar() + coord_flip() + theme_classic() + xlab("") + ylab("Percent reporting challenge") + scale_y_continuous(limits=c(0,100))
dev.off()


pdf(file="figures/features.pdf", width = 15, height = 6, useDingbats = FALSE)
grid.table(features[,c("answer", "percent", "psiTurk")])
dev.off()
