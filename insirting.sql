create database charity ;

-- Create the organization table 
CREATE  TABLE charity_organization
(
    id INT primary key,
    charity_name VARCHAR(50),
    charity_address VARCHAR(50),
    phone VARCHAR(20),
    contact_info VARCHAR(30),
	manager_id int,

)
-- Create the employee table
CREATE TABLE Employee
(
    emp_id INT  primary key,
    emp_name VARCHAR(50),
    salary DECIMAL(10, 2),
   emp_phone VARCHAR(20),
    emp_mail VARCHAR(30),
	org_id int,
)

--add relationshib between employee_charity 
alter table charity_organization
add constraint employee_charity_fk foreign key(manager_id)
references employee(emp_id)

--add relationshib between chariy_employee
	alter table employee
	add constraint chariy_employee_fk foreign key(org_id)
	references charity_organization(id)

	-- Create the project table
CREATE TABLE project
(
    p_id INT primary key,
    p_name VARCHAR(50),
	org_id int,
	constraint chariy_project_fk foreign key(org_id)
	references charity_organization(id)
)

-- Create the volunteers table
CREATE TABLE volunteers
(
    vol_id INT primary key,
    vol_name VARCHAR(50),
    vol_mail VARCHAR(30),
	vol_phone VARCHAR(20),
	org_id int,
	constraint chariy_volunteers_fk foreign key(org_id)
	references charity_organization(id)
)
-- Create the volunteer_project table
CREATE TABLE volunteers_project
(
    pro_id int ,
	vol_id int,
	constraint project_volunteersproject_fk foreign key(pro_id)
	references project(p_id) ,
	constraint volunteers_volunteersproject_fk foreign key(vol_id)
	references volunteers(vol_id)

)

-- Create the beneficiaries table
CREATE TABLE beneficiaries
(
    ben_id INT primary key,
    ben_name VARCHAR(50),
    ben_phone VARCHAR(20),
	ben_address VARCHAR(50),

)
-- Create the donor table
CREATE TABLE donor
(
    donor_id INT primary key,
    donor_name VARCHAR(50),
	donation_amount DECIMAL(10, 2), 
	donation_date date,
    donor_phone VARCHAR(20),
	donor_mail VARCHAR(30),
	org_id int,
	constraint charity_organization_donor_fk foreign key(org_id)
	references charity_organization(id)

)
-- Create the charity_beneficiaries table 
CREATE TABLE charity_beneficiaries
(
    ben_id int ,
	org_id int,
	constraint beneficiaries_charitybeneficiaries_fk foreign key(ben_id)
	references beneficiaries(ben_id) ,
	constraint charity_charitybeneficiaries_fk foreign key(org_id)
	references charity_organization(id)

)

--charity_organization
insert into charity_organization (id, charity_name, charity_address, phone, contact_info) values (1, 'mersal upper', '261 Nova Trail', '401-366-5843', 'bharriman0@tinypic.com');
insert into charity_organization (id, charity_name, charity_address, phone, contact_info) values (2, 'mersal cairo', '47 Veith Crossing', '604-190-4265', 'ihuygen1@google.de');
insert into charity_organization (id, charity_name, charity_address, phone, contact_info) values (3, 'mersal sinai', '411 Twin Pines Place', '964-724-2383', 'jrodrigo2@webeden.co.uk');
insert into charity_organization (id, charity_name, charity_address, phone, contact_info) values (4, 'mersal siwa', '1 Ramsey Plaza', '897-437-7022', 'galecock3@ft.com');

--employee
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (501, 'Guinna Navarijo', 22715, '760-855-5748', 'gnavarijo0@webs.com', 4);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (502, 'Dorothea Trenoweth', 21958, '143-393-7138', 'dtrenoweth1@ft.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (503, 'Hurley Franssen', 7805, '176-754-8435', 'hfranssen2@ihg.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (504, 'Reeva MacCall', 10705, '429-412-5785', 'rmaccall3@paypal.com', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (505, 'Orin Preskett', 13031, '320-469-9947', 'opreskett4@feedburner.com', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (506, 'Carlee Coppenhall', 21669, '765-927-7343', 'ccoppenhall5@qq.com', 4);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (507, 'Nikki Skedgell', 20379, '797-837-8817', 'nskedgell6@sogou.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (508, 'Jacqueline Barukh', 15469, '212-972-3881', 'jbarukh7@posterous.com', 4);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (509, 'Victoria Mithan', 8087, '718-152-0066', 'vmithan8@accuweather.com', 4);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (510, 'Penny Scoffham', 22336, '803-115-1001', 'pscoffham9@meetup.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (511, 'Felipa Baudassi', 14833, '773-888-1023', 'fbaudassia@cargocollective.com', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (512, 'Gabriel Courtese', 17063, '517-858-9435', 'gcourteseb@flickr.com', 4);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (513, 'Carina Bunton', 11558, '348-871-4235', 'cbuntonc@imageshack.us', 4);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (514, 'Boigie Sawbridge', 20755, '500-193-3630', 'bsawbridged@blogspot.com', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (515, 'Reinald McKinnon', 22823, '224-108-7149', 'rmckinnone@meetup.com', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (516, 'Ilene Pfeffer', 16379, '487-646-2517', 'ipfefferf@ox.ac.uk', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (517, 'Gareth Mulholland', 19335, '849-466-8151', 'gmulhollandg@marketwatch.com', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (518, 'Ronni Severn', 13615, '277-298-6656', 'rsevernh@stumbleupon.com', 2);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (519, 'Parry Chasier', 22692, '200-346-5736', 'pchasieri@msu.edu', 1);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (520, 'Abbie Serris', 12542, '649-235-9414', 'aserrisj@xrea.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (521, 'Isa Chadbourne', 21167, '753-780-8124', 'ichadbournek@mapy.cz', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (522, 'Nataniel Strachan', 13161, '580-354-8638', 'nstrachanl@statcounter.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (523, 'Dulcea Antonelli', 23862, '959-933-8666', 'dantonellim@i2i.jp', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (524, 'Sindee Cabrara', 12006, '554-103-0069', 'scabraran@discovery.com', 3);
insert into employee (emp_id, emp_name, salary, emp_phone, emp_mail, org_id) values (525, 'Tomasina Lacaze', 20846, '745-764-7613', 'tlacazeo@hibu.com', 3);

--project
insert into project (p_id, p_name, org_id) values (10001, 'Perl Breinl', 1);
insert into project (p_id, p_name, org_id) values (10002, 'Stanly Mettricke', 1);
insert into project (p_id, p_name, org_id) values (10003, 'Erl O''Devey', 1);
insert into project (p_id, p_name, org_id) values (10004, 'Elenore Hazelhurst', 3);
insert into project (p_id, p_name, org_id) values (10005, 'Mirabelle Rodder', 4);
insert into project (p_id, p_name, org_id) values (10006, 'Royall Medland', 4);
insert into project (p_id, p_name, org_id) values (10007, 'Clarinda Cadle', 2);
insert into project (p_id, p_name, org_id) values (10008, 'Celia Ramalhete', 2);
insert into project (p_id, p_name, org_id) values (10009, 'Gray Gritsaev', 1);
insert into project (p_id, p_name, org_id) values (10010, 'Doris MacCafferky', 4);
----- volunteer
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3001, 'Reena Cluley', 'rcluley0@booking.com', '874-279-3239', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3002, 'Rici Kob', 'rkob1@soup.io', '468-208-7797', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3003, 'Eric Wolton', 'ewolton2@howstuffworks.com', '156-363-7755', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3004, 'Hubie McCallam', 'hmccallam3@dell.com', '594-498-1099', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3005, 'Marty Cheesley', 'mcheesley4@163.com', '603-747-6770', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3006, 'Patten Heppenspall', 'pheppenspall5@washington.edu', '317-432-1266', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3007, 'Jobyna Eadmeads', 'jeadmeads6@cdbaby.com', '346-943-1427', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3008, 'Rubia Maharey', 'rmaharey7@livejournal.com', '259-171-9480', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3009, 'Nita McMickan', 'nmcmickan8@toplist.cz', '592-803-4350', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3010, 'Teirtza Guilaem', 'tguilaem9@mozilla.org', '152-945-7030', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3011, 'Berte Somner', 'bsomnera@youku.com', '976-672-5405', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3012, 'Gertrud Van Arsdall', 'gvanb@sogou.com', '562-924-7628', 3);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3013, 'Corinna Feathers', 'cfeathersc@bloomberg.com', '493-270-5876', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3014, 'Ninnette Sabbin', 'nsabbind@plala.or.jp', '881-353-9234', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3015, 'Alysia Normington', 'anormingtone@ustream.tv', '737-363-0595', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3016, 'Victoir Bixley', 'vbixleyf@spiegel.de', '291-974-6981', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3017, 'Slade Greenleaf', 'sgreenleafg@mlb.com', '555-801-6204', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3018, 'Vallie Fagge', 'vfaggeh@jiathis.com', '218-552-9559', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3019, 'Ofelia Jammet', 'ojammeti@networksolutions.com', '816-692-2813', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3020, 'Sandye Cummins', 'scumminsj@soundcloud.com', '121-731-3152', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3021, 'Alejoa de Courcey', 'adek@sphinn.com', '611-287-1556', 3);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3022, 'Herbert Calderwood', 'hcalderwoodl@alibaba.com', '476-484-6701', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3023, 'Dorolice Burde', 'dburdem@storify.com', '314-207-5765', 3);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3024, 'Ardys Karlsen', 'akarlsenn@mit.edu', '888-276-6474', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3025, 'Cele Beany', 'cbeanyo@usa.gov', '914-778-6343', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3026, 'Bertrand Batrim', 'bbatrimp@uiuc.edu', '983-903-2459', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3027, 'Aldo Oliva', 'aolivaq@un.org', '332-965-2420', 3);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3028, 'Horton Hawkin', 'hhawkinr@amazon.com', '259-835-7366', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3029, 'Ransom Enever', 'renevers@cnet.com', '819-907-4795', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3030, 'Austin Janes', 'ajanest@dmoz.org', '256-516-9174', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3031, 'Merridie MacIver', 'mmaciveru@about.com', '638-954-5667', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3032, 'Berthe Lutsch', 'blutschv@unicef.org', '338-182-1803', 3);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3033, 'Pryce Snoddin', 'psnoddinw@newsvine.com', '830-974-1037', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3034, 'Matty Maydway', 'mmaydwayx@instagram.com', '138-314-4996', 2);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3035, 'Madelene Halliwell', 'mhalliwelly@netlog.com', '449-342-1554', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3036, 'Timothee Oddie', 'toddiez@state.gov', '781-242-0312', 4);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3037, 'Lisabeth Snelson', 'lsnelson10@slashdot.org', '944-945-7717', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3038, 'Vikki Szimon', 'vszimon11@de.vu', '391-396-4871', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3039, 'Birgit Dansey', 'bdansey12@bbc.co.uk', '482-552-6357', 1);
insert into volunteers (vol_id, vol_name, vol_mail, vol_phone, org_id) values (3040, 'Yale Higford', 'yhigford13@is.gd', '190-593-9211', 4);
-----donor
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15001, 'Honey Tiller', 7306, '4/10/2023', '915-762-4175', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15002, 'Sydel Dyka', 14930, '8/12/2023', '954-979-2603', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15003, 'Ebony MacConnel', 15374, '5/29/2023', '804-904-8759', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15004, 'Marta Cairney', 12078, '9/26/2022', '932-628-2530', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15005, 'Devinne Durrad', 15814, '11/9/2022', '331-986-5989', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15006, 'Sophi Saldler', 6100, '12/7/2022', '633-235-3553', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15007, 'Bord Boughtflower', 13630, '12/21/2022', '683-219-6727', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15008, 'Sibel Harle', 10858, '11/2/2022', '722-833-8340', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15009, 'Shelley Velasquez', 5395, '4/26/2023', '177-803-4207', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15010, 'Jayne Shegog', 16624, '7/9/2023', '655-192-2561', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15011, 'Lennie Flintiff', 15240, '2/2/2023', '405-573-3184', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15012, 'Sari Pacitti', 14350, '6/17/2023', '127-929-9688', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15013, 'Claudina Keane', 11741, '9/11/2022', '325-539-3477', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15014, 'Gabriell Vallack', 14221, '5/16/2023', '533-410-9088', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15015, 'Ileana Byer', 10341, '2/2/2023', '669-527-2070', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15016, 'Zuzana Salvatore', 16870, '5/29/2023', '632-554-8114', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15017, 'Romain Alkin', 2699, '11/24/2022', '830-116-2382', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15018, 'Aimil Queyos', 14423, '12/19/2022', '959-495-7053', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15019, 'Phaedra Rapi', 4598, '9/9/2022', '605-728-4619', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15020, 'Jeanie Minghi', 17048, '1/21/2023', '603-919-2538', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15021, 'Laurie Edgeler', 341, '9/3/2022', '508-255-1901', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15022, 'Tristam Staker', 17680, '3/1/2023', '741-753-8490', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15023, 'Jodi Harfleet', 587, '10/2/2022', '428-570-2959', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15024, 'Brook Breadon', 18400, '4/11/2023', '827-791-9339', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15025, 'Charissa Pim', 12083, '7/1/2023', '447-420-3696', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15026, 'Ferdie Adamowitz', 9535, '10/2/2022', '143-898-3561', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15027, 'Nerta Jakubczyk', 2767, '10/23/2022', '945-791-9113', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15028, 'Bryant Tidey', 19192, '7/6/2023', '983-907-3305', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15029, 'Gusta Jouhning', 5202, '4/27/2023', '201-200-6324', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15030, 'Deeanne Beneteau', 4526, '2/6/2023', '258-553-2120', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15031, 'Eleen Creyke', 11454, '4/11/2023', '755-241-3117', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15032, 'Maude Blampy', 16596, '12/24/2022', '294-540-8207', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15033, 'Emlyn Landrick', 1309, '7/15/2023', '497-574-8059', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15034, 'Glenine Burchall', 18702, '6/30/2023', '116-984-6803', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15035, 'Natasha Naisbet', 4729, '4/14/2023', '530-178-5981', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15036, 'Lavena Thorneloe', 15744, '5/15/2023', '163-312-4744', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15037, 'Ermin MacAnellye', 3553, '10/22/2022', '595-189-2638', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15038, 'Nickola Dominichetti', 19291, '3/25/2023', '653-291-6141', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15039, 'Morley Grenshields', 10120, '8/4/2023', '635-259-1630', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15040, 'Violette Grisedale', 5393, '4/11/2023', '364-410-7154', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15041, 'Darryl Udie', 15369, '4/29/2023', '479-263-4728', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15042, 'Maje Kuhwald', 16806, '10/17/2022', '593-988-7485', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15043, 'Domini Older', 16223, '6/7/2023', '395-946-2447', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15044, 'Kitti Sealand', 11179, '6/4/2023', '687-121-0872', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15045, 'Ronald Stocky', 11638, '10/5/2022', '923-878-9643', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15046, 'Libbi Bentzen', 19609, '8/29/2022', '156-655-9136', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15047, 'Anya Feacham', 1122, '8/26/2022', '737-276-1718', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15048, 'Kaitlynn Matyatin', 3893, '3/9/2023', '763-295-5124', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15049, 'Sibella Aleksic', 10186, '11/27/2022', '752-565-0018', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15050, 'Shandee Ruberry', 17918, '7/9/2023', '480-913-6490', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15051, 'Reece Milleton', 14956, '3/18/2023', '144-414-2679', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15052, 'Sheffie Barcroft', 15581, '6/9/2023', '122-122-3266', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15053, 'Heall Hanwell', 15526, '5/11/2023', '322-380-4177', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15054, 'Susy Attlee', 2070, '9/26/2022', '371-615-9018', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15055, 'Loria Gabel', 14752, '11/10/2022', '746-962-3166', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15056, 'Xylia Fitzsimmons', 15257, '2/12/2023', '784-281-1806', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15057, 'Demetrius Timothy', 4675, '3/1/2023', '226-957-0279', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15058, 'Rosalynd Dugue', 15078, '7/31/2023', '803-261-7049', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15059, 'Langston Everit', 18810, '8/24/2022', '464-354-5552', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15060, 'Odessa Monkeman', 3703, '3/1/2023', '616-271-0045', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15061, 'Vasili Dyet', 14503, '1/1/2023', '841-366-7759', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15062, 'Trixie Hartly', 14286, '7/5/2023', '486-595-3487', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15063, 'Peggie Colegrove', 19898, '12/2/2022', '394-895-2211', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15064, 'Rene Itzcovich', 11375, '1/5/2023', '783-995-0232', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15065, 'Jed Frentz', 663, '4/18/2023', '632-114-1492', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15066, 'Walsh Pavitt', 2819, '2/7/2023', '763-676-3499', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15067, 'Pepita Shafto', 1404, '2/8/2023', '267-978-2203', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15068, 'Niels Fetherby', 1792, '7/10/2023', '564-476-7595', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15069, 'Morgan Wilshaw', 245, '9/27/2022', '937-207-3921', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15070, 'Chrisse Dowgill', 18588, '3/18/2023', '846-739-2673', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15071, 'Ambrosius Larrad', 11135, '5/6/2023', '916-454-9599', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15072, 'Lynnet Horribine', 4659, '5/29/2023', '560-350-1543', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15073, 'Chaim Dumingos', 11480, '3/5/2023', '615-919-3163', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15074, 'Kaela Foulcher', 12175, '9/11/2022', '757-581-5065', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15075, 'Ludovico Gamlen', 19202, '12/5/2022', '232-235-2413', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15076, 'Frederique Grimston', 6977, '6/16/2023', '984-192-0167', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15077, 'Sophey Moorhouse', 15146, '5/13/2023', '391-969-0070', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15078, 'Hadleigh Aindriu', 3929, '5/31/2023', '409-328-0409', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15079, 'Donny Wank', 7116, '10/31/2022', '565-299-7544', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15080, 'Lucila Nolin', 6220, '4/20/2023', '665-175-7870', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15081, 'Clarice Kornilov', 2310, '2/2/2023', '922-802-5356', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15082, 'Marquita Paireman', 11637, '7/16/2023', '132-891-8446', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15083, 'Sella Chaimson', 16819, '5/5/2023', '761-127-4670', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15084, 'Dominique Veasey', 3029, '10/10/2022', '996-966-5586', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15085, 'Alina Dawtry', 11320, '1/30/2023', '171-100-9790', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15086, 'Bevin Gagg', 10692, '5/30/2023', '457-390-6785', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15087, 'Alysa Klaffs', 15873, '5/10/2023', '962-842-9499', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15088, 'Amandy Egglestone', 4001, '12/11/2022', '273-500-7273', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15089, 'Reidar Laterza', 534, '1/6/2023', '420-981-5686', 1);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15090, 'Dorene Magnus', 19211, '2/3/2023', '123-577-1857', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15091, 'Alejandrina Gateshill', 18703, '7/19/2023', '362-118-7394', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15092, 'Aldridge McGibbon', 6644, '2/10/2023', '392-269-9104', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15093, 'Cindee Ainslie', 6730, '12/23/2022', '549-668-5189', 4);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15094, 'Cad Tapson', 13573, '7/15/2023', '708-881-8922', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15095, 'Aidan Raddon', 15944, '4/4/2023', '902-511-8622', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15096, 'Bertrand Derye-Barrett', 18526, '3/4/2023', '924-463-4283', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15097, 'Chucho Szanto', 15031, '9/3/2022', '773-438-5423', 2);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15098, 'Blondell Ondrousek', 18583, '11/6/2022', '430-199-1767', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15099, 'Fraze Jodlkowski', 11363, '10/13/2022', '997-948-5439', 3);
insert into donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id) values (15100, 'Kailey Rosie', 3817, '11/4/2022', '561-502-3227', 4);

--beneficiaries
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20001, 'Silvanus Dragge', '685-581-6856', '5 Farmco Pass');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20002, 'Byran Lingfoot', '108-241-5696', '57136 Dixon Court');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20003, 'Ozzie Monck', '955-513-1159', '8619 Northport Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20004, 'Gerda Ambrois', '563-888-2326', '35000 Burrows Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20005, 'Lloyd Helmke', '703-447-3490', '561 Ludington Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20006, 'Vivianne Rochford', '916-309-3717', '88 Nevada Center');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20007, 'Dorella Fulmen', '724-294-2383', '29066 Reindahl Junction');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20008, 'Parsifal Gerran', '340-225-9607', '5386 Golf Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20009, 'Nikaniki Walisiak', '940-739-8677', '14505 Burrows Trail');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20010, 'Harri Mcimmie', '869-728-3438', '39890 Elka Plaza');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20011, 'Myra Luther', '917-632-3216', '2735 Westport Point');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20012, 'Farrand Paulig', '255-571-5597', '219 Di Loreto Alley');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20013, 'Sarene Buckler', '123-980-0987', '57683 Springs Pass');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20014, 'Tiena Caulkett', '641-954-7913', '53 Prentice Alley');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20015, 'Chelsae McPhee', '227-578-3711', '74400 Esch Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20016, 'Guy Walster', '633-762-1563', '072 Hudson Center');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20017, 'Si Westphalen', '614-674-6385', '29 Banding Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20018, 'Corinne Tenny', '242-856-5373', '08647 Bartillon Lane');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20019, 'Belita Iveson', '391-250-0517', '50369 Chinook Place');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20020, 'Magda Coppock.', '323-804-7254', '6948 Manitowish Terrace');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20021, 'Gratia Blunsden', '580-444-0942', '629 Dryden Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20022, 'Tonia Autie', '879-873-9715', '288 Dapin Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20023, 'Dukey Hyam', '597-607-8916', '58134 Jackson Avenue');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20024, 'Kathleen Quarton', '532-666-2439', '5 Colorado Trail');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20025, 'Jewelle Occleshaw', '554-579-9048', '533 Nancy Plaza');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20026, 'Desiri Belle', '620-124-5944', '8302 Ohio Junction');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20027, 'Margarette Halliwell', '701-162-0176', '5 Bowman Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20028, 'Anabelle Chamberlain', '171-421-5364', '09 Steensland Place');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20029, 'Murdock Charlewood', '109-467-5613', '2803 Quincy Road');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20030, 'Gordon Crowden', '149-820-6724', '3 Melvin Center');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20031, 'Hilary Loges', '181-243-0688', '88271 Redwing Avenue');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20032, 'Terri Lyddyard', '851-157-8065', '34906 Surrey Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20033, 'Jdavie Rosettini', '400-263-2699', '39 Eastwood Court');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20034, 'Ricard Drakes', '707-968-0923', '5493 Clove Place');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20035, 'Katharyn Lippard', '984-683-0658', '58 Bay Drive');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20036, 'Layne Fishleigh', '567-405-1067', '3809 Claremont Avenue');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20037, 'Betteann Truckell', '309-313-9150', '5 Northfield Terrace');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20038, 'Sydel Croxon', '408-738-0578', '78115 Michigan Parkway');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20039, 'Emylee Sturridge', '819-571-9290', '9 Ridge Oak Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20040, 'Sher Barajaz', '748-339-7919', '290 Clove Junction');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20041, 'Robinetta Colson', '996-631-5078', '9 Talisman Circle');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20042, 'Gilberta Godbold', '853-414-8263', '8431 Trailsway Hill');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20043, 'Hughie Moyne', '542-806-6193', '6153 Old Gate Plaza');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20044, 'Mara McGeechan', '547-763-7083', '37 Carpenter Avenue');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20045, 'Deva Thornber', '250-236-5203', '17165 Jenifer Center');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20046, 'Linet Huett', '101-733-7996', '55 Oriole Hill');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20047, 'Cody Tort', '470-612-3034', '3 Butterfield Alley');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20048, 'Cordy Isbell', '369-116-6918', '823 Helena Road');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20049, 'Evered Cawsey', '998-694-9467', '82142 Rockefeller Drive');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20050, 'Lorianne Schellig', '677-237-6074', '4 Dovetail Drive');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20051, 'Myrlene Le Leu', '859-754-2759', '8 Dexter Hill');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20052, 'Lynnea Imason', '371-858-2305', '008 Garrison Road');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20053, 'Grete Arndt', '577-318-0383', '70 Menomonie Place');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20054, 'Gus Chalcroft', '906-212-6405', '330 5th Point');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20055, 'Kippy Brafield', '990-965-5377', '4 Killdeer Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20056, 'Kailey Tadd', '685-673-7685', '90 East Plaza');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20057, 'Court Scranney', '379-930-0182', '2353 Thackeray Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20058, 'Tedman Bortol', '168-180-6500', '8 Briar Crest Drive');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20059, 'Ashleigh Metts', '243-791-5297', '912 Corry Avenue');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20060, 'Goddart Whitely', '555-479-4361', '39 Lake View Parkway');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20061, 'Catie Trenbey', '763-897-4152', '1985 Crowley Junction');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20062, 'Howie Paxeford', '759-762-3154', '997 Ridgeview Park');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20063, 'Garrett Sarginson', '109-673-4256', '80294 Saint Paul Point');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20064, 'Lauree Isted', '777-524-1795', '24 Oak Valley Center');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20065, 'Carmel Harrisson', '418-648-4688', '8903 Debra Point');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20066, 'Matti Meakes', '115-656-5848', '645 Moulton Place');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20067, 'Ida Darragh', '112-286-9869', '485 Schlimgen Road');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20068, 'Sosanna Vautier', '232-656-4328', '1 American Ash Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20069, 'Obediah Coal', '627-400-7091', '5074 Pearson Alley');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20070, 'Gasparo Marcombe', '207-169-0379', '22 Portage Way');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20071, 'Roseanna Gumn', '535-852-6500', '089 Toban Court');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20072, 'Camile Fearnyhough', '462-985-0652', '457 Nobel Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20073, 'Abbye Greenhough', '284-963-5092', '1108 David Parkway');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20074, 'Heinrick Kluge', '436-438-9684', '15 Reinke Lane');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20075, 'Koral Kernley', '341-322-5561', '397 Manufacturers Street');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20076, 'Clair Blackston', '654-565-2894', '1781 Butternut Terrace');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20077, 'Vladamir Dimelow', '431-831-1011', '989 Autumn Leaf Plaza');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20078, 'Ingrim Dumper', '690-798-9226', '796 Talisman Drive');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20079, 'Nessi Anthonies', '215-346-1762', '86 Shopko Crossing');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20080, 'Con Witterick', '462-788-4766', '509 Sauthoff Street');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20081, 'Gonzalo Joontjes', '479-286-8150', '060 Hazelcrest Point');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20082, 'Cobby Brimicombe', '861-527-1569', '841 Southridge Lane');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20083, 'Fanechka Poles', '233-196-7099', '611 Independence Alley');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20084, 'Renie Southerton', '695-433-1222', '270 Brentwood Street');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20085, 'Elset Beynkn', '399-538-8804', '89 Kropf Avenue');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20086, 'Ware Masseo', '112-850-5793', '9 Trailsway Circle');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20087, 'Darlleen Wellen', '476-477-6873', '7614 Quincy Parkway');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20088, 'Darbie Nial', '819-608-2797', '2460 Canary Point');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20089, 'Vassily Foulcher', '749-654-0944', '43073 Prentice Parkway');
insert into beneficiaries (ben_id, ben_name, ben_phone, ben_address) values (20090, 'Leland Waterfall', '458-452-8031', '358 2nd Circle');
---volunteers_project
insert into volunteers_project (pro_id, vol_id) values (10008, 3009);
insert into volunteers_project (pro_id, vol_id) values (10005, 3006);
insert into volunteers_project (pro_id, vol_id) values (10003, 3022);
insert into volunteers_project (pro_id, vol_id) values (10008, 3037);
insert into volunteers_project (pro_id, vol_id) values (10008, 3002);
insert into volunteers_project (pro_id, vol_id) values (10010, 3027);
insert into volunteers_project (pro_id, vol_id) values (10005, 3014);
insert into volunteers_project (pro_id, vol_id) values (10001, 3012);
insert into volunteers_project (pro_id, vol_id) values (10002, 3007);
insert into volunteers_project (pro_id, vol_id) values (10008, 3015);
insert into volunteers_project (pro_id, vol_id) values (10008, 3038);
insert into volunteers_project (pro_id, vol_id) values (10003, 3020);
insert into volunteers_project (pro_id, vol_id) values (10008, 3033);
insert into volunteers_project (pro_id, vol_id) values (10007, 3033);
insert into volunteers_project (pro_id, vol_id) values (10003, 3003);
insert into volunteers_project (pro_id, vol_id) values (10004, 3024);
insert into volunteers_project (pro_id, vol_id) values (10004, 3007);
insert into volunteers_project (pro_id, vol_id) values (10009, 3018);
insert into volunteers_project (pro_id, vol_id) values (10010, 3008);
insert into volunteers_project (pro_id, vol_id) values (10006, 3033);
--  charity_beneficiaries
insert into charity_beneficiaries (ben_id, org_id) values (20050, 3);
insert into charity_beneficiaries (ben_id, org_id) values (20015, 2);
insert into charity_beneficiaries (ben_id, org_id) values (20053, 1);
insert into charity_beneficiaries (ben_id, org_id) values (20048, 3);
insert into charity_beneficiaries (ben_id, org_id) values (20048, 4);
insert into charity_beneficiaries (ben_id, org_id) values (20044, 1);
insert into charity_beneficiaries (ben_id, org_id) values (20081, 3);
insert into charity_beneficiaries (ben_id, org_id) values (20010, 4);
insert into charity_beneficiaries (ben_id, org_id) values (20065, 4);
insert into charity_beneficiaries (ben_id, org_id) values (20067, 4);
insert into charity_beneficiaries (ben_id, org_id) values (20065, 1);
insert into charity_beneficiaries (ben_id, org_id) values (20028, 1);
insert into charity_beneficiaries (ben_id, org_id) values (20041, 3);
insert into charity_beneficiaries (ben_id, org_id) values (20086, 1);


--