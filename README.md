<h1>Samp Project Roleplay</h1>
<p>นี่คือโปรเจคที่พัฒนาต่อจาก <a href="https://github.com/aktah/samp-open-roleplay">Samp Open Roleplay</a></p>
<p>เราอ้างอิงการทำโปรเจคโดยอิงตาม <a href="#">SW:RP</a> เป็นหลักหากมีบางระบบที่มีการเสริมหรือแต่งไปนั้นทำเพื่อความสดวกและง่ายต่อการจัดการ</p>
<p>เราไม่ได้มีเจตจตนาที่จะทำให้ สคลิปนี้พังแต่มีเจตตนาเพื่อเป็นแนวทางความรู้หมายๆของเจ้าของ <a href="#">Samp Project Roleplay</a>เราอาจะทำให้พวกคุณไม่พอใจ<br> กับสิ่งที่เรานั้นกระทำลงไปแต่เราได้ทำด้วยความพยามและมุ่งมานะเป็นอย่างมากในการทำโปรเจคตัวนี้ขึ้นมา
    และขอบคุณคุณ <a href="https://github.com/aktah">Leaks</a>ที่ให้ความรู้และแนวทางต่างๆ</p>

<h2>??ลิขสิทธิ์</h2>

<p>เรายังใช้ ลิขสิทธ์เดียวกัยกับ <a href="https://github.com/aktah/samp-open-roleplay">Samp Open Roleplay</a></p>
<p>จึงจำเป็นต้องทำตามกฏที่มีกำหนดไว้ดังกล่าวด้วย</p>
<p style="color: red;">เนื่องจากเราไม่ใช่ต้นฉบับในการเริ่มต้นตามกฎของ โปรเจคต้นฉบับดังกล่าวไว้เพื่อเป็นการไม่ถือครอง ลิขสิทธ์ ที่ไม่ใช่ของตนเอง</p>

<h2>?? การติดตั้ง</h2>
#### หากคุณยังไม่ได้ติดตั้ง sampctl; โปรดไปติดตั้งมันก่อนเป็นอย่างแรก **ความต้องการ:** - พื้นฐานการเขียนโปรแกรม - การแก้ปัญหาเบื้องต้น - ระบบปฏิบัติการที่ต้องการ Linux (Ubuntu 18+) หรือวินโดว์ 10+ - [SAMPCTL](https://github.com/Southclaws/sampctl) - [GIT](https://git-scm.com/downloads)
- MySQL - [Xampp](https://www.apachefriends.org/xampp-files/7.3.12/xampp-windows-x64-7.3.12-0-VC15-installer.exe) --- ### ตั้งค่าและติดตั้งโหมดเกมนี้ #### การตั้งค่า O:RP - โคลนที่เก็บโปรเจคนี้จาก github - เปิด Command Prompt หรือ Power Shell Prompt ในไดเรกทอรีที่โคลน
- ไปที่ `gamemodes/configuration/` และสร้างไฟล์ database.pwn พร้อมเขียนตั้งค่ารูปแบบนี้ ``` #define MYSQL_HOST "โฮสต์ของคุณ" // ปกติเป็น localhost #define MYSQL_USER "ชื่อผู้ใช้" #define MYSQL_PASS "รหัสผ่าน" #define MYSQL_DB "ชื่อฐานข้อมูล" ``` - พิมพ์
`sampctl package ensure` - คุณจะได้รับไฟล์ `dependencies` สำหรับคอมไพล์สคริปต์ - พิมพ์ `sampctl package build` เพื่อคอมไพล์ (**อย่าลืมตั้งค่าการเชื่อมต่อ MYSQL**) - หลังจากนั้นเซิร์ฟเวอร์ก็พร้อมที่จะรันแล้ว พิมพ์ `sampctl package run` **ตัวย่อ** คุณสามารถใช้
`p` แทน `package` ได้ อย่างเช่น `sampctl p run`