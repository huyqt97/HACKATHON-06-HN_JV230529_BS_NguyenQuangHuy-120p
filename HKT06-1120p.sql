create database quanlydiemthi;
use quanlydiemthi;
create table student(
student_id varchar(4) not null primary key,
student_name varchar(100) not null,
birthday date not null,
gender bit default 1 not null,
address text not null,
phone_number varchar(45)
);
create table subject(
subject_id varchar(4) primary key not null,
subject_name varchar(45) not null,
priority int(11) not null
);
create table mark(
subject_id varchar(4) not null,
student_id varchar(4) not null,
point double not null,
foreign key(subject_id) references subject(subject_id),
foreign key(student_id) references student(student_id)
);
-- BT2
-- 1, thêm dữ liệu

insert into student(student_id,student_name,birthday,gender,address,phone_number) values("S001","Nguyễn Thế Anh","1999/1/11",1,"Hà Nội","984678082"),
("S002","Đặng Bảo Trâm","1998/12/22",0,"Lào Cai","904982654"),
("S003","Trần Hà Phương","2000/5/5",0,"Nghệ An","947645363"),
("S004","Đỗ Tiến Mạnh","1999/3/26",1,"Hà Nội","983665353"),
("S005","Phạm Duy Nhất","1998/10/4",1,"Tuyên Quang","987242678"),
("S006","Mai Văn Thái","2002/6/22",1,"Nam Định","982754268"),
("S007","Giang Gia Hân","1996/11/10",0,"Phú Thọ","982364753"),
("S008","Nguyễn Ngọc Bảo My","1999/1/22",0,"Hà Nam","927867453"),
("S009","Nguyễn Tiến Đạt","1998/8/7",1,"Tuyên Quang","989274673"),
("S010","Nguyễn Thiều Quang","2000/9/18",1,"Hà Nội","984378291");
INSERT INTO SUBJECT(subject_Id,subject_name,priority) VALUE 
("MH01", "Toán",2),("MH02", "Vật Lý",2),("MH03", "Hóa Học",1),("MH04", "Ngữ Văn",1),("MH05", "Tiếng Anh",2); 
INSERT INTO mark(student_id,subject_id,point) VALUE 
("S001","MH01", 8.5),("S001","MH02", 7),("S001","MH03", 9),("S001","MH04", 9),("S001","MH05", 5),
("S002","MH01", 9),("S002","MH02", 8),("S002","MH03", 6.5),("S002","MH04", 8),("S002","MH05", 6),
("S003","MH01", 7.5),("S003","MH02", 6.5),("S003","MH03", 8),("S003","MH04", 7),("S003","MH05", 7),
("S004","MH01", 6),("S004","MH02", 7),("S004","MH03", 5),("S004","MH04", 6.5),("S004","MH05", 8),
("S005","MH01", 5.5),("S005","MH02", 8),("S005","MH03", 7.5),("S005","MH04", 8.5),("S005","MH05", 9),
("S006","MH01", 8),("S006","MH02", 10),("S006","MH03", 9),("S006","MH04", 7.5),("S006","MH05", 6.5),
("S007","MH01", 9.5),("S007","MH02", 9),("S007","MH03", 6),("S007","MH04", 9),("S007","MH05", 4),
("S008","MH01", 10),("S008","MH02", 8.5),("S008","MH03", 8.5),("S008","MH04", 6),("S008","MH05", 9.5),
("S009","MH01", 7.5),("S009","MH02", 7),("S009","MH03", 9),("S009","MH04", 5),("S009","MH05", 10),
("S010","MH01", 6.5),("S010","MH02", 8),("S010","MH03", 5.5),("S010","MH04", 4),("S010","MH05", 7);
-- 2, cập nhập dữ liệu
update student set student_name = "Đỗ Đức Mạnh" where student_id = "S004";
update subject set subject_name = "Ngoại ngữ", priority = 1 where subject_id = "MH05";
update mark
set point = case 
    when subject_id = 'MH01' then 8.5
    when subject_id = 'MH02' then 7
    when subject_id = 'MH03' then 5.5
    when subject_id = 'MH04' then 6
    when subject_id = 'MH05' then 9
end
where student_id = 'S009';
-- 3, xóa dữ liệu
delete from mark where student_id = 'S010';
delete from student where student_id = 'S010';
-- Bt3 truy vấn dữ liệu
-- 1, Lấy ra tất cả thông tin của sinh viên trong bảng Student 
select * from student;
-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1.
select subject_id as "Mã môn học",subject_name as "Tên Môn học" from subject where priority = 1; 
 -- 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
-- năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh.
select student_id as 'Mã học sinh',student_name as 'Tên học sinh',
    year(CURDATE()) - year(birthday) as 'Tuổi',
    case
        when gender = 1 then 'Nam'
        when gender = 0 then 'Nữ'
    end as 'Giới tính',
    address as 'Quê quán'
from student;
-- 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
-- Toán và sắp xếp theo điểm giảm dần.
select st.student_name,s.subject_name,m.point from student as st join mark as m on st.student_id = m.student_id
 join subject as s on m.subject_id = s.subject_id 
 order by m.point desc;
 -- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
 select     case
        when gender = 1 then 'Nam'
        when gender = 0 then 'Nữ'
    end as 'Giới tính'
    ,count(student_id) as "Số lượng" from student 
 group by gender
 having count(student_id);
 -- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
-- để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.
select st.student_id as "Mã học sinh",st.student_name as "Tên học sinh",sum(m.point) as "Tổng điểm", avg(m.point) as "Điểm trung bình" from student as st join mark as m on st.student_id = m.student_id
group by st.student_id, st.student_name;
-- Bài 4: Tạo View, Index, Procedure
-- 1, Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học
-- sinh, giới tính , quê quán .
create view student_view as
select student_id as "Mã học sinh",student_name as "Tên học sinh",gender as "Giới tính",address as "Địa chỉ" from student;
-- 2, Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
-- điểm trung bình các môn học .
create view AVERAGE_MARK_VIEW as 
select st.student_id as "Mã học sinh",st.student_name as "Tên học sinh", avg(m.point) as "Điểm trung bình"  from student as st join mark m on st.student_id = m.student_id
group by st.student_id;
-- 3, Đánh Index cho trường `phoneNumber` của bảng STUDENT.
create index idx_phoneNumber
on student (phone_number);
-- 4, Tạo các PROCEDURE sau:
-- - Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả
-- thông tin học sinh đó.
delimiter //
create procedure PROC_INSERTSTUDENT(in student_id varchar(4),in student_name varchar(100),in birthday date,in gender bit,in address text,in phone_number varchar(45))
begin
    insert into student(student_id, student_name, birthday, gender, address, phone_number)
    values(student_id, student_name, birthday, gender, address, phone_number);
end //
delimiter ;
--  Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
delimiter //
create procedure PROC_UPDATESUBJECT(in subject_id varchar(4),in new_subject_name varchar(45))
begin
    update subject
    set subject_name = new_subject_name
    where subject_id = subject_id;
end //
delimiter ;
-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học
-- sinh và trả về số bản ghi đã xóa.
delimiter //
create procedure PROC_DELETEMARK(in student_id varchar(4),out deleted_records int)
begin
    delete from mark
    where student_id = student_id;
    set deleted_records = ROW_COUNT();
end //
delimiter ;
