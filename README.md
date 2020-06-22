# Econ 771: Health Economics II

This is a PhD course in Health Economics, taught by [Ian McCarthy](http://ianmccarthyecon.com) at Emory University. Before going much further, please be sure to read the full [syllabus](syllabus/syllabus-771.pdf), which provides more details on class policies and learning objectives. 

This ReadMe file is the landing page for our class website. Below, I provide details on resources, course logistics, assignments, and the course schedule. This site is very much a work-in-progress, so be sure to check back regularly for updates. Better yet, you can clone the repo via *Git* and then pull regularly to get updates. If you're not familiar with GitHub, take a look at the excellent notes from [Grant McDermott](https://grantmcdermott.com/) and his class, [Data Science for Economists](https://github.com/uo-ec607/lectures). 

## Main Resources

To get the most out of this class, we need to use a handful of tools. Some of these may be new to you (I'm still learning too!), but I've selected all of these resources deliberately. They should complement each other and build relevant skills for any applied economics researcher.

1. **Canvas**: This is where I'll post announcements and any grades. We'll also use Canvas for our discussion forums.

2. **OneNote**: Everyone will soon receive an invitation to join our OneNote classroom. This will provide you with your own notebook for the class, where you can take your own notes and have access to all of my annotated notes from class. Note that all of the notes (without annotation) are also available below.

3. **GitHub**: Everyone will also soon receive an invitation to join our GitHub classroom. This is where you can access all code files and datasets that we'll use in the class. This is also how you will submit your main replication project.

4. **Amazon Web Services**: Everyone will have access to cloud computing through AWS. This will serve as your own virtual computer, so we all have the same data capabilities, versions, and packages.

5. **Zoom**: All office hours and one-on-one meetings will take place virtually in our private Zoom meeting room. Details of the room are available on *Canvas*.

6. **Me!** Please reach out to me for any reason. I will answer emails as promptly as possible (definitely within 24 hours), and we can meet virtually whenever I am available. If you'd like to meet virtually, just go to [https://ian-meetings.youcanbook.me](https://ian-meetings.youcanbook.me) and find a time that works.



## Course Outline and Notes
Below are all of the slides relevant for each class. The slides will open as html files. Be sure to check the *OneNote* notebook for any annotated notes from each class, accessible via our *OneNote classroom*. 


### Module 0. Motivation and expectations for the class

### Module 1. The hospital objective function and financial incentives

**Learning objectives**
  - Synthesize the literature on hospital ownership type and its effects on healthcare outcomes
  - Recognize identification strategies in applied empirical work  
  - Identify potential barriers to "selection on observables" and difference-in-differences in practice
  - Analyze real data on hospital ownership type, prices, and quality
  - Describe the Medicare prospective payment system and the idea of "upcoding" in claims data

**Papers**<br>
  - Class 3, 9/2: Duggan (2000), Horwitz and Nichols (2009), Bayindir (2012). Note that Horwitz and Nichols (2009) and Bayindir (2012) are combined in the class presentations. Both of those papers are closely related and so it makes sense to present those papers together. The papers are also relatively short.
  - Class 4, 9/7: Dafny (2005), Dranove and Ody (2019)
  - Class 5, 9/16: Dranove (1988), Dranove et al. (2017). I will briefly present the Dranove (1988) paper in the beginning of class and discuss the main source of debate in this literature. Dranove et al. (2017) is the only student-led presentation for this class.


**Identification strategies**<br>
  - Selection on observables (not really an identification strategy...more of an assumption to facilitate causal inference with purely observational data)
  - Difference-in-differences (and the role of event studies)


**Main datasets**<br>
  - [HCRIS](https://github.com/imccart/HCRIS)
  - [Provider of Services](https://github.com/asacarny/provider-of-services)
  - [Hospital Compare](https://github.com/asacarny/hospital-compare)
  - [Physician Fee Schedule](https://github.com/imccart/PFS_Update_2010)



2. Physician agency and treatment decisions

3. Information disclosure

4. Mergers and healthcare competition

5. Key issues for health insurance markets





## Assignments
1. Attendance and discussion: I know this is a PhD class, and taking "attendance" is odd at this level. But since so much of this class is about presenting and discussing existing work, it's really critical that we're all present. Hence, attendance and participation in our online discussions is a small portion of the grade. This is particulary important if we have to move to fully online course again.

2. Presentations: You will present two papers throughout the course of the semester. A list of potential papers and other instructions is available on the [presentations](assignments/presentations.html) page of our class website. Please inform me of your selected papers no later than **August 21, 2020**.

3. Referee report: You will write a brief referee report and letter to the editor. A list of potential papers on which to write your report, as well as detailed instructions, is available on the [report](assignments/report.html) page of our class webiste. Please inform me of your selected paper no later than **September 4, 2020**. Your report and letter are due by **Friday, October 23, 2020**.

4. Literature review (2nd year) or draft paper (3rd year): You will prepare a literature review or a preliminary draft paper depending on how far along you are in the PhD program. Details of these assignments are available on the [literature review](assignments/lit-review.html) and [draft paper](assignments/draft-paper.html) pages of our website. This assignment is due by **Friday, November 13, 2020**.

5. Replication: You will replicate a published paper using publicly available data. Details of this assignment and a list of potential papers to replicate are available on the [replication](assignments/replication.html) page of our class website. You can also choose to replicate a paper off of the list, but I must approve any selection by **Friday, September 4, 2020**. Your final replication is due no later than **Friday, December 11, 2020** (the day of our scheduled final exam). 


## GitHub Repositories (and other data)
We'll use the following GitHub repositories and other datasets throughout the course. Each repo deals with a different group of datasets.

1. [Medicare Advantage](https://github.com/imccart/Medicare-Advantage)

2. [HCRIS](https://github.com/imccart/HCRIS)

3. [Provider of Services](https://github.com/asacarny/provider-of-services)

4. [Hospital Compare](https://github.com/asacarny/hospital-compare)

5. [Physician Fee Schedule](https://github.com/imccart/PFS_Update_2010). See also the replication files for [Dranove and Ody (2019)](https://www.aeaweb.org/articles?id=10.1257/pol.20170020).

6. [National Inpatient Sample, HCUP](https://www.hcup-us.ahrq.gov/db/nation/nis/nisdbdocumentation.jsp)

## Acknowledgements
This class (and in particular the *R Markdown* formatting and animations) have benefitted significantly from several people who have been generous enough to make their website and other programs available to the public. Some of those people include:

1. [Grant McDermott](https://grantmcdermott.com/) at the University of Oregon. His *GitHub* repository for [Data Science for Economists](https://github.com/uo-ec607/lectures) offers a wealth of information.

2. [Nick Huntington-Klein](http://nickchk.com/) at CSU Fullerton. His causal inference animations are hugely helpful, in addition to the notes for his causal inference class. All of this information is available at his website.

3. [Adam Sacarny](http://sacarny.com/) at Columbia University. He has some great hospital data made available through several *GitHub* respositories, this includes repositories for [HCRIS Data](https://github.com/asacarny/hospital-cost-reports) and [Provider of Services Data](https://github.com/asacarny/provider-of-services).

4. [Jenny Bryan](https://jennybryan.org/) has some incredible resources for people learning *R* and *GitHub*. Her and Jim Hester's [Happy Git and GitHub with R](https://happygitwithr.com/) is a great reference.