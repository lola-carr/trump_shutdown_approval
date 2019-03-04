capture log close
capture log using "Empirical.log", replace

cd "C:\Users\lmc10\Downloads"


summarize djia num_tweets shutdown post_shutdown daysofsd dayspostsd

summarize djia num_tweets shutdown post_shutdown daysofsd dayspostsd if shutdown!=0
summarize djia num_tweets shutdown post_shutdown daysofsd dayspostsd if post_shutdown!=0


reg approve djia num_tweets shutdown post_shutdown daysofsd dayspostsd, r
eststo model1
ovtest
vif

reg disapprove djia num_tweets shutdown post_shutdown daysofsd dayspostsd, r
eststo model2
esttab, r2 ar2 se scalar(rmse)
ovtest
vif

graph twoway (lfit approve dayspostsd if post_shutdown==1) (scatter approve dayspostsd if post_shutdown==1), title("Approval Rating With Fitted Regression")

graph twoway (lfit approve daysofsd if shutdown==1) (scatter approve daysofsd if shutdown==1), title("Approval Rating With Fitted Regression")

*Unneeded, just graphs constant
coefplot, keep(*cons *djia *num_tweets) title("Approval Rating With Fitted Regression")


test shutdown post_shutdown

test daysofsd dayspostsd
