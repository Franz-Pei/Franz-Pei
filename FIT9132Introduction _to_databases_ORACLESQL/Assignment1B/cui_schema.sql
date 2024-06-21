set echo on
spool cui_schema_output.txt

--Group:184
-- Kezia Amanda Sukardi: 30118441
-- Pranav Bijapur: 32940122
-- Ziqi Pei : 33429472

-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-05-03 16:02:58 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c



DROP TABLE auth_truck CASCADE CONSTRAINTS;

DROP TABLE authority CASCADE CONSTRAINTS;

DROP TABLE bin CASCADE CONSTRAINTS;

DROP TABLE bintype CASCADE CONSTRAINTS;

DROP TABLE collection CASCADE CONSTRAINTS;

DROP TABLE contract CASCADE CONSTRAINTS;

DROP TABLE contract_bin_type CASCADE CONSTRAINTS;

DROP TABLE contract_waste_type CASCADE CONSTRAINTS;

DROP TABLE driver CASCADE CONSTRAINTS;

DROP TABLE made_collection CASCADE CONSTRAINTS;

DROP TABLE owner CASCADE CONSTRAINTS;

DROP TABLE ownerprop CASCADE CONSTRAINTS;

DROP TABLE property CASCADE CONSTRAINTS;

DROP TABLE street CASCADE CONSTRAINTS;

DROP TABLE truck CASCADE CONSTRAINTS;

DROP TABLE wastetype CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE auth_truck (
    approval   VARCHAR2(1 CHAR) NOT NULL,
    truck_vin  VARCHAR2(17 CHAR) NOT NULL,
    driver_num NUMBER(2) NOT NULL
);

COMMENT ON COLUMN auth_truck.approval IS
    'truck approval';

COMMENT ON COLUMN auth_truck.truck_vin IS
    'truck vin';

COMMENT ON COLUMN auth_truck.driver_num IS
    'driver number';

ALTER TABLE auth_truck ADD CONSTRAINT auth_truck_pk PRIMARY KEY ( truck_vin,
                                                                  driver_num );

CREATE TABLE authority (
    auth_name       VARCHAR2(20) NOT NULL,
    auth_ceo_fname  VARCHAR2(30) NOT NULL,
    auth_ceo_lname  VARCHAR2(30) NOT NULL,
    auth_contact    CHAR(10) NOT NULL,
    auth_total_area NUMBER(9, 2) NOT NULL,
    auth_type       NUMBER(1) NOT NULL
);

ALTER TABLE authority
    ADD CONSTRAINT local_auth_type CHECK ( auth_type IN ( 1, 2, 3, 4, 5 ) );

COMMENT ON COLUMN authority.auth_name IS
    'authority name
';

COMMENT ON COLUMN authority.auth_ceo_fname IS
    'the first name of authority  ceo';

COMMENT ON COLUMN authority.auth_ceo_lname IS
    'the last name of authority ceo';

COMMENT ON COLUMN authority.auth_contact IS
    'authority contact number';

COMMENT ON COLUMN authority.auth_total_area IS
    'total area if the authority';

COMMENT ON COLUMN authority.auth_type IS
    'type of the authority';

ALTER TABLE authority ADD CONSTRAINT authority_pk PRIMARY KEY ( auth_name );

CREATE TABLE bin (
    bin_rfid              VARCHAR2(16 CHAR) NOT NULL,
    bin_supply_date       DATE NOT NULL,
    bin_replace_reason    NUMBER(1),
    bin_actual_supplycost NUMBER(5, 2) NOT NULL,
    prop_num              NUMBER(5) NOT NULL,
    waste_type_id         NUMBER(1) NOT NULL,
    bin_size              NUMBER(3) NOT NULL,
    con_num               NUMBER(4) NOT NULL
);

ALTER TABLE bin
    ADD CONSTRAINT bin_replacement_reason CHECK ( bin_replace_reason IN ( 1, 2, 3, 4 )
    );

COMMENT ON COLUMN bin.bin_rfid IS
    'bin rfid';

COMMENT ON COLUMN bin.bin_supply_date IS
    'bin supply date';

COMMENT ON COLUMN bin.bin_replace_reason IS
    'replacement reson of the bin';

COMMENT ON COLUMN bin.bin_actual_supplycost IS
    'add actual supplyest';

COMMENT ON COLUMN bin.prop_num IS
    'property number';

COMMENT ON COLUMN bin.waste_type_id IS
    'Waste type ID';

COMMENT ON COLUMN bin.bin_size IS
    'Bin size';

COMMENT ON COLUMN bin.con_num IS
    'Contract number.';

ALTER TABLE bin ADD CONSTRAINT entity_18_pk PRIMARY KEY ( bin_rfid );

CREATE TABLE bintype (
    bin_size          NUMBER(3) NOT NULL,
    bin_standard_cost NUMBER(4) NOT NULL,
    waste_type_id     NUMBER(1) NOT NULL
);

COMMENT ON COLUMN bintype.bin_size IS
    'Bin size';

COMMENT ON COLUMN bintype.bin_standard_cost IS
    'Bin suplly standard cost';

COMMENT ON COLUMN bintype.waste_type_id IS
    'Waste type ID';

ALTER TABLE bintype ADD CONSTRAINT bt_size_pk PRIMARY KEY ( waste_type_id,
                                                            bin_size );

CREATE TABLE collection (
    coll_date     VARCHAR2(20 CHAR) NOT NULL,
    waste_type_id NUMBER(1) NOT NULL,
    truck_vin     VARCHAR2(17 CHAR) NOT NULL,
    driver_num    NUMBER(2) NOT NULL,
    con_num       NUMBER(4) NOT NULL
);

COMMENT ON COLUMN collection.coll_date IS
    'date of collection';

COMMENT ON COLUMN collection.waste_type_id IS
    'Waste type ID';

COMMENT ON COLUMN collection.truck_vin IS
    'truck vin';

COMMENT ON COLUMN collection.driver_num IS
    'driver number';

COMMENT ON COLUMN collection.con_num IS
    'Contract number.';

ALTER TABLE collection
    ADD CONSTRAINT collection_pk PRIMARY KEY ( coll_date,
                                               waste_type_id,
                                               con_num );

CREATE TABLE contract (
    con_num        NUMBER(4) NOT NULL,
    con_start_date DATE NOT NULL,
    con_end_date   DATE NOT NULL,
    auth_name      VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN contract.con_num IS
    'Contract number.';

COMMENT ON COLUMN contract.con_start_date IS
    'contract start date';

COMMENT ON COLUMN contract.con_end_date IS
    'contract end date';

COMMENT ON COLUMN contract.auth_name IS
    'authority name
';

ALTER TABLE contract ADD CONSTRAINT contract_pk PRIMARY KEY ( con_num );

CREATE TABLE contract_bin_type (
    contract_bin_supplycost NUMBER(6, 2) NOT NULL,
    waste_type_id           NUMBER(1) NOT NULL,
    bin_size                NUMBER(3) NOT NULL,
    con_num                 NUMBER(4) NOT NULL
);

COMMENT ON COLUMN contract_bin_type.contract_bin_supplycost IS
    'supply cost of the bin type in the contract';

COMMENT ON COLUMN contract_bin_type.waste_type_id IS
    'Waste type ID';

COMMENT ON COLUMN contract_bin_type.bin_size IS
    'Bin size';

COMMENT ON COLUMN contract_bin_type.con_num IS
    'Contract number.';

ALTER TABLE contract_bin_type
    ADD CONSTRAINT conbintype_pk PRIMARY KEY ( waste_type_id,
                                               bin_size,
                                               con_num );

CREATE TABLE contract_waste_type (
    contract_waste_type_cost     NUMBER(6, 2) NOT NULL,
    contect_waste_type_frequency NUMBER(1) NOT NULL,
    waste_type_id                NUMBER(1) NOT NULL,
    con_num                      NUMBER(4) NOT NULL
);

ALTER TABLE contract_waste_type
    ADD CONSTRAINT waste_coll_freq CHECK ( contect_waste_type_frequency IN ( 1, 2, 3 )
    );

COMMENT ON COLUMN contract_waste_type.contract_waste_type_cost IS
    'cost of waste type in the contract';

COMMENT ON COLUMN contract_waste_type.contect_waste_type_frequency IS
    'Frequency of collection of the waste';

COMMENT ON COLUMN contract_waste_type.waste_type_id IS
    'Waste type ID';

COMMENT ON COLUMN contract_waste_type.con_num IS
    'Contract number.';

ALTER TABLE contract_waste_type ADD CONSTRAINT conwasteype_pk PRIMARY KEY ( waste_type_id
,
                                                                            con_num )
                                                                            ;

CREATE TABLE driver (
    driver_num      NUMBER(2) NOT NULL,
    driver_lic      NUMBER(9) NOT NULL,
    driver_fname    VARCHAR2(10) NOT NULL,
    driver_lname    VARCHAR2(10) NOT NULL,
    driver_dob      VARCHAR2(10 CHAR) NOT NULL,
    driver_tax_num  NUMBER(9) NOT NULL,
    driver_cont_num NUMBER(10) NOT NULL
);

COMMENT ON COLUMN driver.driver_num IS
    'driver number';

COMMENT ON COLUMN driver.driver_lic IS
    'driver licence number';

COMMENT ON COLUMN driver.driver_fname IS
    'driver''s first name';

COMMENT ON COLUMN driver.driver_lname IS
    'driver''s first name';

COMMENT ON COLUMN driver.driver_dob IS
    'driver''s date of birth';

COMMENT ON COLUMN driver.driver_tax_num IS
    'driver''s tax file number';

COMMENT ON COLUMN driver.driver_cont_num IS
    'driver''s contact number';

ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY ( driver_num );

CREATE TABLE made_collection (
    coll_over_weight CHAR(1 CHAR) NOT NULL,
    coll_weight      NUMBER(3),
    bin_rfid         VARCHAR2(16 CHAR) NOT NULL,
    coll_date        VARCHAR2(20 CHAR) NOT NULL,
    waste_type_id    NUMBER(1) NOT NULL,
    con_num          NUMBER(4) NOT NULL
);

COMMENT ON COLUMN made_collection.coll_over_weight IS
    'indication whether collection is overweight';

COMMENT ON COLUMN made_collection.coll_weight IS
    'weight of the collection';

COMMENT ON COLUMN made_collection.bin_rfid IS
    'bin rfid';

COMMENT ON COLUMN made_collection.coll_date IS
    'date of collection';

COMMENT ON COLUMN made_collection.waste_type_id IS
    'Waste type ID';

COMMENT ON COLUMN made_collection.con_num IS
    'Contract number.';

ALTER TABLE made_collection
    ADD CONSTRAINT made_collection_pk PRIMARY KEY ( bin_rfid,
                                                    coll_date,
                                                    waste_type_id,
                                                    con_num );

CREATE TABLE owner (
    owner_id    CHAR(5) NOT NULL,
    owner_fname VARCHAR2(30) NOT NULL,
    owner_lname VARCHAR2(30) NOT NULL,
    ower_email  VARCHAR2(30) NOT NULL,
    owner_phone CHAR(10) NOT NULL
);

COMMENT ON COLUMN owner.owner_id IS
    'owner id';

COMMENT ON COLUMN owner.owner_fname IS
    'owner frst name';

COMMENT ON COLUMN owner.owner_lname IS
    'owner last name';

COMMENT ON COLUMN owner.ower_email IS
    'owner email address';

COMMENT ON COLUMN owner.owner_phone IS
    'owner phone number';

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_id );

CREATE TABLE ownerprop (
    owner_id CHAR(5) NOT NULL,
    prop_num NUMBER(5) NOT NULL
);

COMMENT ON COLUMN ownerprop.owner_id IS
    'owner id';

COMMENT ON COLUMN ownerprop.prop_num IS
    'property number';

ALTER TABLE ownerprop ADD CONSTRAINT ownerprop_pk PRIMARY KEY ( owner_id,
                                                                prop_num );

CREATE TABLE property (
    prop_num        NUMBER(5) NOT NULL,
    auth_name       VARCHAR2(20) NOT NULL,
    street_id       CHAR(7) NOT NULL,
    prop_street_num NUMBER(5) NOT NULL
);

COMMENT ON COLUMN property.prop_num IS
    'property number';

COMMENT ON COLUMN property.auth_name IS
    'authority name
';

COMMENT ON COLUMN property.street_id IS
    'street id';

COMMENT ON COLUMN property.prop_street_num IS
    'street number of the property';

ALTER TABLE property ADD CONSTRAINT property_pk PRIMARY KEY ( prop_num );

ALTER TABLE property
    ADD CONSTRAINT prop_num_nk UNIQUE ( prop_street_num,
                                        auth_name,
                                        street_id );

CREATE TABLE street (
    street_id           CHAR(7) NOT NULL,
    street_name         VARCHAR2(20) NOT NULL,
    street_length       NUMBER(9, 2) NOT NULL,
    street_surface_type NUMBER(1) NOT NULL,
    street_lane_num     NUMBER(2) NOT NULL,
    auth_name           VARCHAR2(20) NOT NULL
);

ALTER TABLE street
    ADD CONSTRAINT road_surface_type CHECK ( street_surface_type IN ( 1, 2, 3 ) );

COMMENT ON COLUMN street.street_id IS
    'street id';

COMMENT ON COLUMN street.street_name IS
    'name of the street';

COMMENT ON COLUMN street.street_length IS
    'the length of the street';

COMMENT ON COLUMN street.street_surface_type IS
    'surface type of the street';

COMMENT ON COLUMN street.street_lane_num IS
    'number of lanes in the street.';

COMMENT ON COLUMN street.auth_name IS
    'authority name
';

ALTER TABLE street ADD CONSTRAINT street_pk PRIMARY KEY ( street_id,
                                                          auth_name );

CREATE TABLE truck (
    truck_vin   VARCHAR2(17 CHAR) NOT NULL,
    truck_rego  VARCHAR2(10 CHAR) NOT NULL,
    truck_make  VARCHAR2(10 CHAR) NOT NULL,
    truck_model VARCHAR2(10 CHAR) NOT NULL,
    truck_year  NUMBER(4) NOT NULL
);

COMMENT ON COLUMN truck.truck_vin IS
    'truck vin';

COMMENT ON COLUMN truck.truck_rego IS
    'truck registration number';

COMMENT ON COLUMN truck.truck_make IS
    'truck make';

COMMENT ON COLUMN truck.truck_model IS
    'truck model';

COMMENT ON COLUMN truck.truck_year IS
    'year the truck was manufactured';

ALTER TABLE truck ADD CONSTRAINT truck_pk PRIMARY KEY ( truck_vin );

CREATE TABLE wastetype (
    waste_type_id   NUMBER(1) NOT NULL,
    waste_type_desc NUMBER(1) NOT NULL
);

ALTER TABLE wastetype
    ADD CHECK ( waste_type_id IN ( 1, 2, 3, 4 ) );

ALTER TABLE wastetype
    ADD CHECK ( waste_type_desc IN ( 1, 2, 3, 4 ) );

COMMENT ON COLUMN wastetype.waste_type_id IS
    'Waste type ID';

COMMENT ON COLUMN wastetype.waste_type_desc IS
    'Waste type description';

ALTER TABLE wastetype ADD CONSTRAINT wastetype_pk PRIMARY KEY ( waste_type_id );

ALTER TABLE collection
    ADD CONSTRAINT auth_truck_collection FOREIGN KEY ( truck_vin,
                                                       driver_num )
        REFERENCES auth_truck ( truck_vin,
                                driver_num );

ALTER TABLE contract
    ADD CONSTRAINT authority_contract FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );

ALTER TABLE street
    ADD CONSTRAINT authority_street FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );

ALTER TABLE made_collection
    ADD CONSTRAINT bin_made_collection FOREIGN KEY ( bin_rfid )
        REFERENCES bin ( bin_rfid );

ALTER TABLE bin
    ADD CONSTRAINT bintype_bin FOREIGN KEY ( waste_type_id,
                                             bin_size )
        REFERENCES bintype ( waste_type_id,
                             bin_size );

ALTER TABLE contract_bin_type
    ADD CONSTRAINT bintype_conbintype FOREIGN KEY ( waste_type_id,
                                                    bin_size )
        REFERENCES bintype ( waste_type_id,
                             bin_size );

ALTER TABLE made_collection
    ADD CONSTRAINT collection_made_collection FOREIGN KEY ( coll_date,
                                                            waste_type_id,
                                                            con_num )
        REFERENCES collection ( coll_date,
                                waste_type_id,
                                con_num );

ALTER TABLE bin
    ADD CONSTRAINT contract_bin FOREIGN KEY ( con_num )
        REFERENCES contract ( con_num );

ALTER TABLE contract_bin_type
    ADD CONSTRAINT contract_bin_type FOREIGN KEY ( con_num )
        REFERENCES contract ( con_num );

ALTER TABLE contract_waste_type
    ADD CONSTRAINT contract_waste_type FOREIGN KEY ( con_num )
        REFERENCES contract ( con_num );

ALTER TABLE collection
    ADD CONSTRAINT contract_waste_type_collection FOREIGN KEY ( waste_type_id,
                                                                con_num )
        REFERENCES contract_waste_type ( waste_type_id,
                                         con_num );

ALTER TABLE auth_truck
    ADD CONSTRAINT driver_auth_truck FOREIGN KEY ( driver_num )
        REFERENCES driver ( driver_num );

ALTER TABLE ownerprop
    ADD CONSTRAINT onwerprop_property FOREIGN KEY ( prop_num )
        REFERENCES property ( prop_num );

ALTER TABLE ownerprop
    ADD CONSTRAINT ownerpr FOREIGN KEY ( owner_id )
        REFERENCES owner ( owner_id );

ALTER TABLE bin
    ADD CONSTRAINT relation_18 FOREIGN KEY ( prop_num )
        REFERENCES property ( prop_num );

ALTER TABLE property
    ADD CONSTRAINT street_property FOREIGN KEY ( street_id,
                                                 auth_name )
        REFERENCES street ( street_id,
                            auth_name );

ALTER TABLE auth_truck
    ADD CONSTRAINT truck_auth_truck FOREIGN KEY ( truck_vin )
        REFERENCES truck ( truck_vin );

ALTER TABLE contract_waste_type
    ADD CONSTRAINT waste_type_contract FOREIGN KEY ( waste_type_id )
        REFERENCES wastetype ( waste_type_id );

ALTER TABLE bintype
    ADD CONSTRAINT wastetype_bintype FOREIGN KEY ( waste_type_id )
        REFERENCES wastetype ( waste_type_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             42
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
SPOOL off
set echo off
