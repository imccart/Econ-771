# Econ 771: Health Economics II

This is a PhD course in Health Economics, taught by [Ian McCarthy](http://ianmccarthyecon.com) at Emory University. 

Before going much further, please be sure to read the [syllabus](syllabus/Econ771-Syllabus.pdf). This provides a sense of what to expect in the course and details of specific assignments and projects. Below are lecture notes and underlying code files for the class. This is very much a work-in-progress, so be sure to check back regularly for updates. Better yet, you can clone the repo via *Git* and then pull regularly to get updates. If you're not familiar with GitHub, take a look at the excellent notes from [Grant McDermott](https://grantmcdermott.com/) and his class, [Data Science for Economists](https://github.com/uo-ec607/lectures). 


## Notes and Slides
Below are all of the slides that I'll use throughout the class. The slides will open as html files. Note that I've disabled "touch" navigation, which means that it's not possible to advance the slides with a touchscreen. I did this because I'll annotate the slides during class, and if touch navigation is enabled, then every time I try to write with a stylus it will advance the slide. 

If you want to see the slides in standard presentation format, you will need to access everything on a desktop or laptop rather than a phone or tablet. Everything is still accessible on a mobile platform, you just need to enable "simplified" view (or reader view in some browsers). I've provided a link for that view in each section. The simplified view will remove the slide/presentation formatting and allow you just to see the whole content as one big website. Some content won't display in the same way, but the content itself will be there.

1. Motivation and expectations for the class


2. The hospital objective function and financial incentives


3. Physician agency and treatment decisions


4. Information disclosure


5. Mergers and healthcare competition


6. Key issues for health insurance markets





## Assignments
1. GitHub and Data Management, Due 2/9, \[[Instructions](assignments/hwk-01.html)\] and \[[answers](assignments/hwk-01-answers.html)\]

2. HCRIS Data and Hospital Pricing, Due 3/2, \[[Instructions](assignments/hwk-02.html)\] and \[[answers](assignments/hwk-02-answers.html)\]

3. Smoking Data and Cigarette Demand, Due 3/25, \[[Instructions](assignments/hwk-03.html)\] and \[[answers](assignments/hwk-03-answers.html)\]
  - [Zoom Class Homework Review, March 30](https://drive.google.com/open?id=1lrxqC-AACSlHyHBywWx5BaO-mkY8rZTa)

4. Quality and Insurance Choice, Due 4/8, \[[Instructions](assignments/hwk-04.html)\] and \[[answers](assignments/hwk-04-answers.html)\]

5. Medicaid Expansion and Uninsurance Rates, Due 4/22, \[[Instructions](assignments/hwk-05.html)\] and \[[answers](assignments/hwk-05-answers.html)\]. Some people have had issues retrieving the data using an API key. The ACS data are available [here](data/insurance.rds) as an `R` data set and [here](data/insurance.txt) as a tab-delimited text file. These data are the same as the "final.insurance" object in the GitHub repo.

6. Research Project, Final Paper Due 5/4, \[[Instructions](assignments/project.html)\]


## GitHub Repositories
We'll use the following GitHub repositories throughout the course. Each repo deals with a different group of datasets.

1. [Medicare Advantage](https://github.com/imccart/Medicare-Advantage)

2. [HCRIS](https://github.com/imccart/HCRIS)

3. [CDC Tax Burden on Tobacco](https://github.com/imccart/CDC-Tobacco)

4. [ACS and Medicaid Expansion](https://github.com/imccart/Insurance-Access)


## Acknowledgements
This class (and in particular the *R Markdown* formatting and animations) have benefitted significantly from several people who have been generous enough to make their website and other programs available to the public. Some of those people include:

1. [Grant McDermott](https://grantmcdermott.com/) at the University of Oregon. His *GitHub* repository for [Data Science for Economists](https://github.com/uo-ec607/lectures) offers a wealth of information.

2. [Nick Huntington-Klein](http://nickchk.com/) at CSU Fullerton. His causal inference animations are hugely helpful, in addition to the notes for his causal inference class. All of this information is available at his website.

3. [Adam Sacarny](http://sacarny.com/) at Columbia University. He has some great hospital data made available through several *GitHub* respositories, this includes repositories for [HCRIS Data](https://github.com/asacarny/hospital-cost-reports) and [Provider of Services Data](https://github.com/asacarny/provider-of-services).

4. [Jenny Bryan](https://jennybryan.org/) has some incredible resources for people learning *R* and *GitHub*. Her and Jim Hester's [Happy Git and GitHub with R](https://happygitwithr.com/) is a great reference.