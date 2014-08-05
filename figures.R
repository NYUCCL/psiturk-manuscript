library("ggplot2")

challenges = data.frame(answers = c("Data is unreliable", "Experiment designs I'm interested\nin do not work well online",
             "Population is unrepresentative", "The technology required\nis too complex",
             "I cannot get IRB approval\nto do online studies",
             "I am based outside the US and\nfind it difficult to use services\nlike Amazon Mechanical Turk",
             "Other"),
    count = c(70, 100, 51, 53, 3, 46, 35),
    percent = c(35, 50, 25, 26, 1, 23, 17))
challenges$answers = factor(challenges$answers, rev(as.character(challenges$answers)))


pdf(file="figures/challenges.pdf", width = 7, height = 4, useDingbats = FALSE)

ggplot(challenges, aes(answers, percent)) + geom_bar() + coord_flip() + theme_classic() + xlab("") + ylab("Percent reporting challenge")

dev.off()
