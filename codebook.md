# Codebook

This codebook describes the data, variables, and transformations used to create the final tidy data set (`tidy_dataset.txt`) for the Getting and Cleaning Data course project.

## Source Data

The original dataset is from the UCI Machine Learning Repository. The data were collected from the accelerometers from the Samsung Galaxy S smartphone.

The full dataset was separated into *training* and *test* datasets, which were merged in this analysis.

---

## Data Files Used

From the **UCI HAR Dataset** folder:

| File | Description |
|-----|-------------|
| `features.txt` | Names of the 561 measurement variables. |
| `activity_labels.txt` | Reference table mapping activity codes to activity names. |
| `train/X_train.txt` | Training feature measurements. |
| `train/y_train.txt` | Activity codes for training data. |
| `train/subject_train.txt` | Subject identifiers for training data. |
| `test/X_test.txt` | Test feature measurements. |
| `test/y_test.txt` | Activity codes for test data. |
| `test/subject_test.txt` | Subject identifiers for test data. |

---

## Steps Performed (Summary)

1. **Merged training and test datasets** into a single dataset.
2. **Extracted only the measurements on mean and standard deviation** using `contains("mean()")` and `contains("std()")`.
3. **Replaced activity codes with descriptive names** using the provided activity labels.
4. **Cleaned and clarified variable names**:
   - `t` → `Time`
   - `f` → `Frequency`
   - `Acc` → `Accelerometer`
   - `Gyro` → `Gyroscope`
   - `Mag` → `Magnitude`
   - Removed duplicate `BodyBody`.
5. **Created a tidy dataset** with the **average of each measurement for each subject and each activity**.

---

## Variables in the Final Tidy Dataset

**Rows:** 180 (30 subjects × 6 activities)  
**Columns:** 68 (1 subject + 1 activity + 66 averaged measurement features)

| Variable Name | Description |
|---------------|-------------|
| `subject` | Identifier (1–30) for the volunteer participant. |
| `activity` | One of six activity categories: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`. |
| All other columns | Average of each mean and standard deviation measurement for that subject/activity combination. Examples include: |
| `TimeBodyAccelerometerMeanX` | Mean time-domain measurement of body accelerometer in X direction. |
| `TimeBodyAccelerometerStdY` | Standard deviation of time-domain body accelerometer in Y direction. |
| `FrequencyBodyGyroscopeMeanZ` | Mean frequency-domain measurement of body gyroscope in Z direction. |
| (and similar variables for all mean/std feature pairs) |

---

## Output File

| File | Description |
|------|-------------|
| `tidy_dataset.txt` | Tidy dataset: average of each measurement variable for each activity and each subject. |

This file can be loaded in R with:

```r
data <- read.table("tidy_dataset.txt", header = TRUE)
