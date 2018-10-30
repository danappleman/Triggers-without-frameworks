# SFDX  App

This is the sample respository for the course:
Play by Play: Adopting Trigger Design Patterns in Existing Salesforce Orgs

## Dev, Build and Test

Each commit represents a step in the course. Checkout individual commits to follow along

## Resources


## Description of Files and Directories


## Issues

Refer to the course for specific descriptions of the various methods and processes. The following notes also apply:

leadTriggerSetFollowup makes sure any lead inserted or updated to Working - Contacted has a Lead Followup task created.

taskTriggerSetStatus looks for task insertion where the task references a lead. When it does, if the lead is "Open - Not Contacted", the lead status is set to Working - Contacted. If the lead status is "Working - Contacted" it is set to "Working Harder"

taskTriggerTrackCount - updates the task count on leads when tasks are inserted, deleted, updated 

Process follow-up on lead accounts checks for leads created with emails other than gmail, hotmail and yahoo. It creates for them a Lead Followup task.

Process first owner worked checks for leads with a user owner and a status that starts with working - updates the first owner worked field to the user

Steps:
Change process follow-up on lead accounts to set additional field so taskTriggerSetStatus can be bypassed.

Bypass first owner worked process if status is changed due to task being created on a lead

Combine field updates on taskTriggerTrackCount and taskTriggersetStatus
