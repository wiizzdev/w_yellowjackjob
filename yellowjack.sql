INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_yellowjack','Yellow Jack',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_yellowjack', 'Yellow Jack', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_yellowjack','Yellow Jack',1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('yellowjack', 'Yellow Jack', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('yellowjack', 0, 'barman', 'Barman', 100, '', ''),
	('yellowjack', 1, 'gerant', 'Gérant', 100, '', ''),
	('yellowjack', 2, 'boss', 'Patron', 100, '', '')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('champagne', 'Champagne', -1),
	('whisky', 'Whisky', -1),
	('biere', 'Bière', -1)
;