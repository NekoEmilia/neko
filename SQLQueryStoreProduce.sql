create proc checklogin
@username nvarchar(50),
@passwords nvarchar(50),
@auth nvarchar(50)
as
begin

select * from Users where username = @username and passwords = @passwords and auth = @auth
end
go


create proc checkdecode
@username nvarchar(50)
as
begin
select username,passwords from Users where username = @username
end
go


create proc checkauth
@username nvarchar(50),
@checkstatus nvarchar(50)
as
begin

select username,checkstatus from Users where username = @username and checkstatus=@checkstatus
end
go
/*exec checkauth 'user1','enable'*/
/*Class*/
create proc loadclass
as
begin

select classid,classname,trainsystem,yearofaddmission,wholesalenumber,class.majorid,majorname from class,major where class.majorid = major.majorid;
end
go


create proc checkdupclass
@classid nvarchar(50)
as
begin

select classid from class where classid = @classid
end
go


create proc insertclass
@classid nvarchar(50),
@classname nvarchar(50),
@trainsystem nvarchar(50),
@yearofaddmission nvarchar(50),
@wholesalenumber nvarchar(50),
@majorid nvarchar(50)
as
begin
insert into class(classid,classname,trainsystem,yearofaddmission,wholesalenumber,majorid) values (@classid,@classname,@trainsystem,@yearofaddmission,@wholesalenumber,@majorid)
end
go


create proc editclass
@classid nvarchar(50),
@classname nvarchar(50),
@trainsystem nvarchar(50),
@yearofaddmission nvarchar(50),
@wholesalenumber nvarchar(50),
@majorid nvarchar(50),
@id nvarchar(50)
as
begin
Update class Set classid = @classid, classname = @classname,trainsystem = @trainsystem, yearofaddmission = @yearofaddmission,wholesalenumber = @wholesalenumber,majorid = @majorid where classid=@id
end
go


create proc editclassidinstudent
@classid nvarchar(50)
as
begin
update student set classid = NULL where classid = @classid
end
go


create proc editclassidsemester
@classid nvarchar(50)
as
begin
update semester set classid = NULL where classid = @classid;
end
go


create proc editnullclassidinstudent
@classid nvarchar(50)
as
begin
update student set classid = @classid where classid is NULL
end
go


create proc editnullclassidinsemester
@classid nvarchar(50)
as
begin
update semester set classid = @classid where classid is NULL
end
go


create proc deleteclass
@classid nvarchar(50)
as
begin
delete from class where classid = @classid
end
go


create proc deletesemester1
@classid nvarchar(50)
as
begin
delete from semester where classid = @classid
end
go


create proc searchclass
@classid nvarchar(50)
as
begin
SELECT @classid = RTRIM(@classid) + '%'; 
select classid,classname,trainsystem,yearofaddmission,wholesalenumber,class.majorid,majorname from class,major where class.majorid = major.majorid and classid like @classid
end
go



 /*Major */
create proc loadmajor
as
begin

select majorid,majorname from major
end
go


create proc checkdupmajor
@majorid nvarchar(50)
as
begin

select majorid from major where majorid = @majorid
end
go


create proc insertmajor
@majorid nvarchar(50),
@majorname nvarchar(50)
as
begin

insert into major(majorid,majorname) values (@majorid,@majorname)
end
go


create proc updatemajor
@majorid nvarchar(50),
@majorname nvarchar(50),
@majorid1 nvarchar(50)
as
begin

Update major Set majorid=@majorid, majorname=@majorname where majorid = @majorid1
end
go


create proc editmajoridinclass
@majorid nvarchar(50)
as
begin

update Class set majorid = NULL where majorid = @majorid
end
go


create proc editnullmajoridinclass
@majorid nvarchar(50)
as
begin

update Class set majorid = @majorid where majorid is NULL
end
go


/*Menu Admin*/
create proc loaduser
as
begin

select userid,username,passwords,auth,checkstatus from users
end
go


create proc checkdupuser
@username nvarchar(50)
as
begin

select username from users where username = @username
end
go


create proc insertuser
@username nvarchar(50),
@passwords nvarchar(50),
@auth nvarchar(50),
@checkstatus nvarchar(50)
as
begin

insert into users(username,passwords,auth,checkstatus) values (@username,@passwords,@auth,@checkstatus)
end
go


create proc updateuser
@username nvarchar(50),
@passwords nvarchar(50),
@auth nvarchar(50),
@userid int
as
begin

Update users Set username=@username,passwords=@passwords,auth=@auth where userid = @userid
end
go


create proc deleteuser
@username nvarchar(50),
@passwords nvarchar(50),
@auth nvarchar(50),
@userid int
as
begin

delete from users where username= @username AND passwords=@passwords AND auth= @auth AND userid = @userid
end
go


create proc deleteuseridinstudent
@userid int
as
begin
update student set userid = NULL where userid = @userid
end
go

create proc updateenable
@userid int
as
begin

Update users Set checkstatus='Enable' where userid = @userid
end
go

create proc updatedisable
@userid int
as
begin

Update users Set checkstatus='Disable' where userid = @userid
end
go


create proc searchuser
@username nvarchar(50)
as
begin
SELECT @username = RTRIM(@username) + '%'; 
select userid,username,passwords,auth,checkstatus from users where username like @username
end
go


/*Score*/
create proc loadscore
@studentid int
as
begin
select DISTINCT score.subjectid,subjectname,credit,score1,score2,semester,score.studentid from subjects,score,semester,class  where semester.subjectid = subjects.subjectid and semester.classid = class.classid and score.subjectid = subjects.subjectid and score.studentid = @studentid
end
go


create proc loaduseruser
@username nvarchar(50)
as
begin
select studentid,firstname,lastname,dayofbirth,sex,placeofbirth,student.userid,student.classid,username,auth,major.majorid,majorname,class.classid from student,users,major,class where student.classid = class.classid and class.majorid = major.majorid and student.userid = users.userid and username = @username
end
go


/*Subject */
create proc loadsubject
as
begin
select subjectid,subjectname,credit from subjects
end
go


create proc checkdupsubject
@subjectid nvarchar(50)
as
begin

select subjectid from subjects where subjectid = @subjectid
end
go



create proc insertsubject
@subjectid nvarchar(50),
@subjectname nvarchar(50),
@credit nvarchar(50)
as
begin

insert into subjects(subjectid,subjectname,credit) values (@subjectid,@subjectname,@credit)
end
go


create proc editsubject
@subjectid nvarchar(50),
@subjectname nvarchar(50),
@credit nvarchar(50),
@subjectid1 nvarchar(50)
as
begin
Update subjects Set subjectid = @subjectid, subjectname = @subjectname,credit =@credit where subjectid = @subjectid1
end
go


create proc editsubjectidsemester
@subjectid nvarchar(50)
as
begin
update semester set subjectid = NULL where subjectid = @subjectid
end
go


create proc editsubjectidscore
@subjectid nvarchar(50)
as
begin
update score set subjectid = NULL where subjectid = @subjectid
end
go


create proc editnullsubjectidinsemester
@subjectid nvarchar(50)
as
begin
update semester set subjectid = @subjectid where subjectid is NULL
end
go


create proc editnullsubjectinscore
@subjectid nvarchar(50)
as
begin
update score set subjectid = @subjectid where subjectid is NULL
end
go


create proc deletesubject
@subjectid nvarchar(50),
@subjectname nvarchar(50),
@credit nvarchar(50)
as
begin
delete from subjects where subjectid = @subjectid AND subjectname = @subjectname AND credit = @credit
end
go


create proc deletesemester
@subjectid nvarchar(50)
as
begin
delete from semester where subjectid = @subjectid
end
go


create proc deletescore
@subjectid nvarchar(50)
as
begin
delete from score where subjectid = @subjectid
end
go


create proc searchsubject
@subjectname nvarchar(50)
as
begin
SELECT @subjectname = RTRIM(@subjectname) + '%'; 
select subjectid,subjectname,credit from subjects where subjectname like @subjectname
end
go


/*InputScore*/
create proc searchscore
@classid nvarchar(50)
as
begin
select distinct studentid,class.classid,subjects.subjectid,subjects.subjectname,score1,score2,semester from score,class,subjects,semester where semester.subjectid = subjects.subjectid and semester.classid = class.classid and score.subjectid = subjects.subjectid and semester.classid = @classid
end
go


create proc editscore
@subjectid nvarchar(50),
@studentid nvarchar(50),
@score1 nvarchar(50),
@score2 nvarchar(50),
@subjectid1 nvarchar(50),
@studentid1 nvarchar(50)
as
begin
Update score Set subjectid = @subjectid, studentid = @studentid,score1 =@score1,score2 = @score2 where subjectid = @subjectid1 and studentid = @studentid1
end
go


/* Semester */
create proc loadsemester
as
begin
select subjectid,classid,semester from semester
end
go


create proc insertsemester
@subjectid nvarchar(50),
@classid nvarchar(50),
@semester nvarchar(50)
as
begin
insert into semester(subjectid,classid,semester) values(@subjectid,@classid,@semester)
end
go


create proc editsemester
@subjectid nvarchar(50),
@classid nvarchar(50),
@semester nvarchar(50),
@subjectid1 nvarchar(50),
@classid1 nvarchar(50)
as
begin
update semester set subjectid = @subjectid,classid = @classid, semester = @semester where subjectid = @subjectid1 and classid =@classid1
end
go


create proc delsemester
@subjectid nvarchar(50),
@classid nvarchar(50),
@semester nvarchar(50),
@subjectid1 nvarchar(50),
@classid1 nvarchar(50)
as
begin
delete from semester where subjectid = @subjectid and classid = @classid and semester = @semester and subjectid = @subjectid1 and classid =@classid1
end
go


create proc checkdupsemester
@subjectid nvarchar(50),
@classid nvarchar(50)
as
begin

select subjectid,classid from semester where subjectid = @subjectid and classid =@classid
end
go


create proc searchsemester
@subjectid nvarchar(50)
as
begin
SELECT @subjectid = RTRIM(@subjectid) + '%'; 
select subjectid,classid,semester from semester where subjectid like @subjectid
end
go


/*Student*/
create proc loadstudent
as
begin
select users.userid,username,passwords,auth,studentid,firstname,lastname,dayofbirth,sex,placeofbirth,student.userid,class.classid,major.majorid,majorname from student,users,major,class where student.classid = class.classid and class.majorid = major.majorid and student.userid = users.userid
end
go

create proc loadnullstudent
as
begin
select distinct studentid,firstname,lastname,dayofbirth,sex,placeofbirth,student.userid,student.classid from student where student.classid is null or student.userid is null
end
go


create proc loadstudentnull
as
begin
SELECT Users.userid,Users.username FROM Users WHERE Users.Auth = 'user' and Users.userid not in ( select Student.userid from Student where Student.userid is not null)
end
go


create proc loadstudentclass
as
begin
select classid,classname,majorname from class,major where class.majorid = major.majorid
end
go


create proc checkdupstudent
@userid nvarchar(50),
@studentid nvarchar(50)
as
begin
select userid,studentid from student where userid =@userid or studentid = @studentid
end
go
/*exec checkdupstudent 7,123*/


create proc insertstudent
@userid nvarchar(50),
@studentid nvarchar(50),
@firstname nvarchar(50),
@lastname nvarchar(50),
@dayofbirth nvarchar(50),
@sex nvarchar(50),
@placeofbirth nvarchar(50),
@classid nvarchar(50)
as
begin
insert into student(userid,studentid,firstname,lastname,dayofbirth,sex,placeofbirth,classid) values (@userid,@studentid,@firstname,@lastname,@dayofbirth,@sex,@placeofbirth,@classid)

end
go


create proc updatestudent
@userid nvarchar(50),
@studentid nvarchar(50),
@firstname nvarchar(50),
@lastname nvarchar(50),
@dayofbirth nvarchar(50),
@sex nvarchar(50),
@placeofbirth nvarchar(50),
@classid nvarchar(50),
@userid1 nvarchar(50),
@studentid1 nvarchar(50)
as
begin
update student set userid=@userid,studentid=@studentid,firstname=@firstname,lastname=@lastname,dayofbirth=@dayofbirth,sex=@sex,placeofbirth=@placeofbirth,classid=@classid where userid=@userid1 or studentid = @studentid1
end
go


create proc deletestudent
@userid nvarchar(50),
@studentid nvarchar(50),
@firstname nvarchar(50),
@lastname nvarchar(50),
@dayofbirth nvarchar(50),
@sex nvarchar(50),
@placeofbirth nvarchar(50),
@classid nvarchar(50),
@userid1 nvarchar(50),
@studentid1 nvarchar(50)
as
begin
delete from student where userid=@userid and studentid=@studentid and firstname=@firstname and lastname=@lastname and dayofbirth=@dayofbirth and sex=@sex and placeofbirth=@placeofbirth and classid=@classid and userid=@userid1 and studentid=@studentid
end
go


create proc deletestudentidinsore
@studentid nvarchar(50)
as
begin
delete from score where studentid = @studentid
end
go


create proc searchstudent
@studentid nvarchar(50)
as
begin
SELECT @studentid = RTRIM(@studentid) + '%'; 
select users.userid,username,passwords,auth,studentid,firstname,lastname,dayofbirth,sex,placeofbirth,student.userid,class.classid,major.majorid,majorname from student,users,major,class where student.classid = class.classid and class.majorid = major.majorid and student.userid = users.userid and student.studentid like @studentid
end
go


/*Score*/
create proc loadregister
@studentid nvarchar(50)
as
begin
select studentid,score.subjectid,subjectname from Score,Subjects where score.subjectid = Subjects.subjectid and studentid=@studentid
end
go


create proc checkdupscore
@studentid nvarchar(50),
@subjectid nvarchar(50)
as
begin
select studentid,subjectid from Score where studentid = @studentid and subjectid = @subjectid
end
go


create proc insertscore
@studentid nvarchar(50),
@subjectid nvarchar(50)
as
begin
insert into score(studentid,subjectid) values (@studentid,@subjectid)
end
go



create proc updatescore
@subjectid nvarchar(50),
@studentid nvarchar(50)
as
begin
update Score set subjectid=@subjectid where studentid = @studentid
end
go


create proc deletescoreuser
@studentid nvarchar(50),
@subjectid nvarchar(50)
as
begin
delete from score where studentid = @studentid and subjectid = @subjectid
end
go


create proc checkduppass
@username nvarchar(50),
@passwords nvarchar(50)
as
begin
select username,passwords from Users where username = @username and passwords = @passwords
end
go


create proc editpass
@passwords nvarchar(50),
@username nvarchar(50)
as
begin
update users set passwords=@passwords where username = @username
end
go
