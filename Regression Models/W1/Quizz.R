# Regression Models Quizz W1
# Question 1
x1 <- c(0.18, -1.54, 0.42, 0.95)
w1 <- c(2, 1, 3, 1)
mean(x1);mean(w1)
lm(w1~x1)

# Question 2 OK
x2 <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y2 <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
mean(y2)
lm(y2~x2-1)
# Alternative
sum(y2 * x2)/sum(x2^2)

# Question 3 OK
data(mtcars)
x3<-mtcars$wt
y3<-mtcars$mpg
coef(lm(y3~x3))
# Alternative way
cor(x3, y3) * sd(y3) / sd(x3)

# Question 4 OK
# cor(x4, y4) => .5
# sd(y4) / sd(x4) => 1 / 1.5
.5*(1/.5)

# Question 5 OK Regression to the mean
# 1.5 * 0.4
.6

# Question 6 OK
x6 <- c(8.58, 10.46, 9.01, 9.64, 8.86)
mn6 <- mean(x6)
sd6 <- sd(x6)
xnorm6 <- (x6-mn6)/sd6

# Question 7 OK
x7 <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y7 <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
x7_2 <- x7 - mean(x7)
y7_2 <- y7 - mean(y7)
b1_7 <- cor(x7_2,y7_2)*(sd(y7_2)/sd(x7_2));b0_7 <- mean(y7_2) - b1_7 * mean(x7_2)
b0_7;b1_7
# Alternative
coef(lm(y7~x7))[1]

# Question 9
x9 <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x9)

# Question 10
# cor(x, y) * sd(y) / sd(x) / corr(y, x) * sd(x)/sd(y)
# cor(x, y) * sd(y)^2 / corr(y, x) * sd(x)^2