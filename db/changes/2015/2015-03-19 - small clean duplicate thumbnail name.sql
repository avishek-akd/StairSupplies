--  there were 2 thumbnails with the same name in the database because of case sensitivity:
-- file.pdf and file.PDF were uploaded but the thumbnail was file_page_1.jpg for both
UPDATE TblFile SET `thumbnail`=NULL, `thumbnail_width`=NULL, `thumbnail_height`=NULL WHERE  `id`=9363;