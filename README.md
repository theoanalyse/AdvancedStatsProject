---
# MAXIMUM LIKELIHOOD ESTIMATION FOR SURVIVAL TIME OF GUINEA PIGS
---

The gamma distrbution is often used to study and sketch the evolution of waiting times in everyday applications such as internet connectivity and traffic signals. In the past few decades, they have also been used to model such waiting times in biological systems and experiments. Here, we utilise survival time data from Bjerkedal (1960), who studied the guinea pig’s capacity to resist infection by tubercle bacilli bacteria using a quantitative approach. Since the guinea pigs were administered with different doses of infectious bacteria, arranging the former according to increasing survival time is highly indicative of their antibiotic resistance capacity.

In this experimentation, we search for compatible distributions and subsequently verify the suitability of the best model. We then perform a complete theoretical analysis of the gamma distribution (which turned out to be the best fit) and program simulations of the Maximum-Likelihood estimators. We have also coded for a visualisation of the evolution of the mean-squared error for different Maximum-Likelihood estimators used for the parameters of the gamma distribution.

---
# Content of the repository
---

- fisher_method.R: R implementation of **Fisher**'s numerical method

- fisher_method.py: Python implementation of **Fisher**'s numerical method

- model_fitting.Rmd: R program to search for compatible distributions, fit them and verify the suitability of the best model

- monte_carlo.R: R implementation of **Monte Carlo** simulations showing the evolution of the Mean-Squared error of Maximum-Likelihood esitmators 

- newton_method.E: R implementation of **Newton-Raphson**'s numerical method

- newton_method.E: Python implementation of **Newton-Raphson**'s numerical method

- report.pdf: The actual report that relates to these files.

<br/>
**Thanks for taking the time to read our report and go through our code!**
