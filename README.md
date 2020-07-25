---
---

This is a PhD course in Health Economics, taught by [Ian McCarthy](http://ianmccarthyecon.com) at Emory University. Before going much further, please be sure to read the full [syllabus](syllabus/syllabus-771.pdf), which provides more details on class policies and learning objectives. 

This ReadMe file is the landing page for our class website. Below, I provide details on resources, course logistics, assignments, and the course schedule. This site is very much a work in progress, so be sure to check back regularly for updates.


## Main Resources
To get the most out of this class, we need to use a handful of tools. Some of these may be new to you (I'm still learning too!), but I've selected all of these resources deliberately. They should complement each other and build relevant skills for any applied empirical economics researcher.

1. **Canvas**: This is where I'll post announcements, grades, and other information only for this class (such as Zoom meeting links).

2. **OneNote**: Everyone will soon receive an invitation to join our OneNote classroom. This will provide you with your own notebook for the class, where you can take your own notes and have access to all of my annotated notes from class. Note that all of the notes (without annotation) will also be available below in the Module links.

3. **GitHub**: Everyone will soon receive an invitation to join our GitHub classroom. This is where you can access code files and datasets (where possible) and organize all of your code for class assignments. This is also how you will submit your assignments. If you're not familiar with GitHub, take a look at the excellent notes from [Grant McDermott](https://grantmcdermott.com/) and his class, [Data Science for Economists](https://github.com/uo-ec607/lectures).

4. **Amazon Web Services**: Everyone will have access to cloud computing through AWS. This will serve as your own virtual computer, so we all have the same data capabilities, versions, and packages. You don't have to use this, but for those of you with limited computing power, this is an easy solution.

5. **Zoom**: All office hours and one-on-one meetings will take place virtually in our private Zoom meeting room. Details of the room are available on *Canvas*.

6. **GroupTweet**: We'll use GroupTweet to facilitate discussions outside of normal class time. I'll set up the group and it will act as our own private Twittersphere.

7. **Me!** Please reach out to me for any reason. I will answer emails as promptly as possible (definitely within 24 hours), and we can meet virtually whenever I am available. If you'd like to meet virtually, just go to [https://ian-meetings.youcanbook.me](https://ian-meetings.youcanbook.me) and find a time that works.



## Course Outline and Notes
The course is divided into a few distinct topic areas. In each area, we'll discuss a handful of papers and finish each module with an empirical exercise using real-world data. The empirical work is designed to replicate or at least approximate many of the key identification strategies and econometric approaches in the literature. Follow the link to each module for more detailed information about each section of the course, including a list of resources, learning objectives, and daily schedule. Each module page will also contain the slides relevant for each class. Be sure to check the *OneNote* notebook for any annotated notes from each class, accessible via our *OneNote classroom*. 


### Module 0. [Motivation and expectations for the class](module-guides/module0.html)

### Module 1. [The hospital objective function and financial incentives](module-guides/module1.html)

### Module 2. [Physician agency and treatment decisions](module-guides/module2.html)

### Module 3. [Information disclosure](module-guides/module3.html)

### Module 4. [Mergers and healthcare competition](module-guides/module4.html)

### Module 5. [Key issues for health insurance markets](module-guides/module5.html)
We won't get to a lot of this, but the resources are here for you if anyone is interested.



## Assignments
There are four main assignments throughout the semester, along with a participation component. More information on each assignment is listed below. Note that I **do not** expect or want anyone to treat these assignments as entirely separate. By that, I mean you should try to identify datasets from the exercises that you can use in your replication project, and you should try to select papers to present that use those data. At a minimum, you should present the paper that you will be replicating. With a little bit of up-front planning, you can create a lot of overlap across assignments, which will make your life much easier. 

1. **Discussion**: Participation in our online discussions is a small portion of the grade. This is particulary important if we have to move to a fully online course again. The goal is just to incentivize you all to participate in this discussion outside of class. Your grade will be based on 10 possible discussion forums/topics. 

2. **Empirical exercises**: Each course module will have an applied component where we spend some time replicating analyses from selected papers based on real-world data. These will require some of your time outside of class to get the data in working order and implement the relevant identification strategy and econometric estimator. This empirical work should heavily complement your replication project as well as your draft paper. All exercises will be assigned through GitHub classroom and will come with clear instructions on the general research question, data sources, and estimation strategies. Details of each empirical exercise are in the following links:
  - [Exercise 1](assignments/exercise1.html): Basics of causal inference with panel data; get some experience using the inpatient prospective payment system final rule files, the provider of services files, and the hospital cost report data.
  - [Exercise 2](assignments/exercise2.html): Instrumental variables
  - [Exercise 3](assignments/exercise3.html): Regression Discontinuity
  - [Exercise 4](assignments/exercise4.html): Hospital markets and demand estimation

3. **Presentations**: You will present two papers throughout the course of the semester. A list of potential papers and other instructions is available on the [presentations](assignments/presentation.html) page of our class website. Please inform me of your selected papers no later than **August 21, 2020**.

4. **Literature review** (2nd year) or **draft paper** (3rd year): You will prepare a literature review or a preliminary draft paper depending on how far along you are in the PhD program. Details of these assignments are available on the [literature review](assignments/lit-review.html) and [draft paper](assignments/draft-paper.html) pages of our website. This assignment is due by **Friday, November 13, 2020**.

5. **Replication**: You will replicate a published paper using publicly available data. Details of this assignment and a list of potential papers to replicate are available on the [replication](assignments/replication.html) page of our class website. You can also choose to replicate a paper off of the list, but I must approve any selection by **Friday, September 4, 2020**. Your final replication is due no later than **Friday, December 11, 2020** (the day of our scheduled final exam). 



## Data
We'll come across the following datasets throughout the course. Some of these link to GitHub repositories that I and others have put together to help with some of the larger, more cumbersome data endeavors. Others are just direct links to the downloadable data on the CMS or NBER websites. This is a long list...the goal is not for you to all use each of these datasets in detail in this class. Rather, the goal is that you have some understanding of the available public use datasets for studying supply-side issues in U.S. healthcare. We'll use a subset of these datasets in our exercises for each module.

1. [Medicare Advantage](https://github.com/imccart/Medicare-Advantage)

2. [HCRIS](https://github.com/imccart/HCRIS)

3. [Provider of Services](https://github.com/asacarny/provider-of-services)

4. [Hospital Compare](https://github.com/asacarny/hospital-compare)

5. [Physician Fee Schedule](https://github.com/imccart/PFS_Update_2010). See also the replication files for [Dranove and Ody (2019)](https://www.aeaweb.org/articles?id=10.1257/pol.20170020).

6. [National Inpatient Sample, HCUP](https://www.hcup-us.ahrq.gov/db/nation/nis/nisdbdocumentation.jsp)

7. [Inpatient Prospective Payment System Final Rule Files](https://data.nber.org/data/cms-impact-file-hospital-inpatient-prospective-payment-system-ipps.html)

8. [Physician Compare](https://data.medicare.gov/data/physician-compare)

9. [Provider Utilization and Payment Data](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier)

10. [Area Health Resources Files](https://data.hrsa.gov/topics/health-workforce/ahrf)

11. [NPPES](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/DataDissemination)

12. [Medicare Part D](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/MCRAdvPartDEnrolData)

13. [Hospital Mergers](https://healthcarepricingproject.org/)

14. [Measuring Hospital Markets](https://github.com/graveja0/health-care-markets)

15. [Hospital Service Area Files](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Hospital-Service-Area-File/index)


## Acknowledgements
This class (and in particular the *R Markdown* formatting and animations) have benefitted significantly from several people who have been generous enough to make their website and other programs available to the public. Some of those people include:

1. [Grant McDermott](https://grantmcdermott.com/) at the University of Oregon. His *GitHub* repository for [Data Science for Economists](https://github.com/uo-ec607/lectures) offers a wealth of information.

2. [Nick Huntington-Klein](http://nickchk.com/) at CSU Fullerton. His causal inference animations are hugely helpful, in addition to the notes for his causal inference class. All of this information is available at his website.

3. [Adam Sacarny](http://sacarny.com/) at Columbia University. He has some great hospital data made available through several *GitHub* respositories, this includes repositories for [HCRIS Data](https://github.com/asacarny/hospital-cost-reports) and [Provider of Services Data](https://github.com/asacarny/provider-of-services).

4. [Jenny Bryan](https://jennybryan.org/) has some incredible resources for people learning *R* and *GitHub*. Her and Jim Hester's [Happy Git and GitHub with R](https://happygitwithr.com/) is a great reference.

5. [Steven Miller](http://svmiller.com/) genrously posted his `R Markdown` syllabus template, which I'm using for this class as well.