create database quanlykhoa
go

--Users
use quanlykhoa
go

--Users
create table Users(
	userid int identity primary key,
	username nvarchar(100) not null unique,
	passwords nvarchar(100)not null ,
	auth nvarchar (100) not null,
	checkstatus nvarchar(100) not null,
);

go
--Major
create table Major(
	majorid nvarchar(100) primary key,
	majorname nvarchar(100),
);

go
--Class
create table Class(
	classid nvarchar(100) primary key,
	classname nvarchar(100)not null,
	trainsystem nvarchar(100) not null,
	yearofaddmission nvarchar(100) not null,
	wholesalenumber nvarchar(100) not null,
	majorid nvarchar(100) foreign key references Major(majorid)
);

go
--Student
create table Student(
	studentid int primary key,
	firstname nvarchar(100) not null,
	lastname nvarchar(100) not null,
	dayofbirth nvarchar(100) not null,
	sex nvarchar(100) not null,
	placeofbirth nvarchar(100) not null,
	userid int foreign key references Users(userid),
	classid nvarchar(100) foreign key references Class(classid)
);

go
--Subjects
create table Subjects(
	subjectid nvarchar(100) primary key,
	subjectname nvarchar(100) not null,
	credit nvarchar(100) not null,
);

go
--Score
create table Score(
	id int identity primary key,
	subjectid nvarchar(100) foreign key references Subjects(subjectid),
	studentid int foreign key references Student(studentid),
	score1 nvarchar(100),
	score2 nvarchar(100),
);

go
--Semester
create table Semester(
	id int identity primary key,
	subjectid nvarchar(100) foreign key references Subjects(subjectid),
	classid nvarchar(100) foreign key references Class(classid),
	semester nvarchar(100) not null,
	
);

go

--Insert Data
insert into Users values('tienthanh','123','manager','enable')
insert into Users values('vanthanh','123','admin','enable')
insert into Users values('nhuthanh','123','user','enable')
insert into Users values('xuanmai','123','user','enable')
insert into Users values('hongngan','123','user','enable')
insert into Users values('hongphu','123','user','enable')

insert into Major values('IT',N'Công nghệ thông tin')

insert into Class values('CNTT',N'Công nghệ thông tin',N'University','2022','45','IT')
insert into Class values('CNTT2',N'Công nghệ thông tin 2',N'University','2023','45','IT')
insert into Class values('CNTT3',N'Công nghệ thông tin 3',N'University','2024','45','IT')
insert into Class values('CNTT4',N'Công nghệ thông tin 4',N'University','2025','45','IT')

insert into Student values('101',N'Văn Tiến Thành',N'Phí','25-12-2002','Male',N'Hải Dương',1,'CNTT4')
insert into Student values('102',N'Văn Thành',N'Trịnh','15-11-2002','Male',N'Hà Nội',2,'CNTT4')
insert into Student values('103',N'Như Thành',N'Tạ','22-2-2002','Male',N'Hà Nội',3,'CNTT4')

insert into Subjects values('LTHDT',N'Lập trình hướng đối tượng','3')
insert into Subjects values('CTDL',N'Cấu trúc dữ liệu và giải thuật','3')
insert into Subjects values('.NET',N'Lập trình.Net','3')

insert into Score values('LTHDT','101','8.0','9.0')
insert into Score values('CTDL','102','8.0','7.0')
insert into Score values('.NET','103','7.0','8.0')


insert into Semester values('LTHDT','CNTT4','I')
insert into Semester values('CTDL','CNTT4','II')
insert into Semester values('.NET','CNTT4','II')


--test Data
begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Users values (N'US' + cast (@i as nvarchar(100)),N'nghuy0' + cast (@i as nvarchar(100)),N'admin',N'admin')
		set @i = @i + 1
	end
end
go

begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Major values (N'MJ' + cast (@i as nvarchar(100)),N'AT0' + cast (@i as nvarchar(100)))
		set @i = @i + 1
	end
end
go

select * from subjects
begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Subjects values (N'SJ' + cast (@i as nvarchar(100)),N'MATH0' + cast (@i as nvarchar(100)),3,cast (@i as int))
		set @i = @i + 1
	end
end
go

select * from class
begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Class values (N'CL' + cast (@i as nvarchar(100)),N'A0' + cast (@i as nvarchar(100)),'University',N'200' + cast (@i as nvarchar(100)),N'2' + cast (@i as nvarchar(100)),cast (@i as int))
		set @i = @i + 1
	end
end
go

select * from student
begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Student values (N'SD' + cast (@i as nvarchar(100)),N'GiaHuy' + cast (@i as nvarchar(100)),N'Nguyen' + cast (@i as nvarchar(100)),cast (@i as nvarchar(100)) + N'-3-1999',N'Male',N'HoChiMinh',cast (@i as int),cast (@i as int))
		set @i = @i + 1
	end
end
go
select * from score
begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Score values (cast (@i as int),cast (@i as int),cast (@i as nvarchar(100)),cast (@i as nvarchar(100)))
		set @i = @i + 1
	end
end
go

begin
	declare @i int = 1
	while @i  < 13
	begin
		insert into Semester values (cast (@i as int),cast (@i as int),N'' + cast (@i as nvarchar(100)))
		set @i = @i + 1
	end
end
go

select subjectid[SubjectID], subjectname[NameSubject], credit[Credit] from subjects
select users.userid,username,passwords,student.studentid,class.classid,firstname,lastname,sex,dayofbirth,placeofbirth,classname,major.majorid,majorname,score1,score2,subjectname,semester 
from Class,Major,Score,Semester,Student,Subjects,Users 
where users.userid = student.userid and class.majorid = major.majorid and student.classid = class.classid and score.studentid = student.studentid and score.subjectid = subjects.subjectid and semester.subjectid = subjects.subjectid and semester.classid = class.classid

select users.userid[UserID],username[Username],passwords[Password],auth[Authirities],student.studentid[StudentID],firstname[FirstName],lastname[LastName],sex[Sex],dayofbirth[DayOfBirth],placeofbirth[PlaceOfBirth]class.classid[ClassID],classname[ClassName] 
from Users,Student,Major,Class
where users.userid = student.userid and class.majorid = major.majorid and student.classid = class.classid
select subjectid, subjectname, credit from subjects
select * from subjects
select * from Users
select * from major
select * from score
select * from semester
select *From Class
select *from student
SELECT username,passwords from Users where username ='admin' and passwords = 'admin'
DELETE FROM score WHERE studentid='175050034'
DELETE FROM student WHERE userid='6'
DELETE FROM users where userid ='6'
UPDATE Users join Student, Major, Class SET username = '" + txtaddusername.Text + "', passwords = '" + txtaddpasswords.Text + "', auth = '" + txtaddauth.Text + "', firstname = N'" + txtaddfirstname.Text + "', lastname = N'" + txtaddlastname.Text + "', major = '" + txtaddmajor.Text + "', sex = '"+txtaddcbsex.Text+"', studentid = '"+ txtaddstudentid.Text+ "', dayofbirth = '" + txtadddayofbirth.Text+"' , classid = '"+txtaddclassid.Text + "', classname ='"+txtaddclassname.Text +"' , placeofbirth = '" + txtaddplaceofbirth.Text + "' 
UPDATE Table1   SET Table1.Column1 = 'name' FROM Table1 T1, Table2 T2 WHERE T1.id = T2.id and T1.id = '100'  
UPDATE Table2 SET Table2.EntityName = 'watch' FROM Table1 T1, Table2 T2 WHERE T1.id = T2.id and T1.id = '100'  COMMIT
UPDATE dbo.OrderItem
SET dbo.OrderItem.LastModifiedDate = GETDATE()
FROM dbo.OrderItem 
  INNER JOIN dbo.[Order] ON dbo.OrderItem.OrderId = dbo.[Order].Id 
WHERE dbo.[Order].OrderNumber = 542393
GO
UPDATE major SET majorid = '123', majorname = 'Banker' from major inner join class on major.majorid = class.majorid where class.majorid = '{123}'
select userid from users where username = 'hanhuy308'
select * from Users
select DISTINCT score.subjectid,subjectname,credit,score1,score2,semester,score.studentid from subjects,score,semester,class  where semester.subjectid = subjects.subjectid and semester.classid = class.classid and score.subjectid = subjects.subjectid and score.studentid = '175050032'
select DISTINCT score.subjectid,subjectname,credit,score1,score2,semester,score.studentid from subjects,score,semester,class where semester.subjectid = subjects.subjectid and semester.classid = class.classid and score.subjectid = Subjects.subjectid and score.studentid = '1750500032'
use quanlykhoa
select classid,classname,majorname from class,major where class.majorid = major.majorid
select users.userid,username,passwords,auth,studentid,firstname,lastname,dayofbirth,sex,placeofbirth,student.userid,class.classid,major.majorid,majorname from student,users,major,class where student.classid = class.classid and class.majorid = major.majorid and student.userid = users.userid
SELECT Users.userid,Users.username FROM Users WHERE Users.userid not in ( select Student.userid from Student where Student.userid is not null)
select classid,classname,majorname from class,major where class.majorid = major.majorid
UPDATE class
SET classid = 'test'
WHERE classid = 'test1'
UPDATE student
SET classid = 'test1'
WHERE classid is null
update Score set studentid = '175050033' where studentid is NULL
insert into class(classid,classname,trainsystem,yearofaddmission,wholesalenumber,majorid) values ('17D1TH01','Tech','University','2017','15','T')

