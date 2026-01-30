IF DB_ID('ClinicaDB') IS NOT NULL
BEGIN
    ALTER DATABASE ClinicaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ClinicaDB;
END
GO

CREATE DATABASE ClinicaDB;
GO
USE ClinicaDB;
GO
-------------------
CREATE TABLE Paciente (
    IdPaciente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    DNI VARCHAR(8),
    FechaNacimiento DATE,
    Sexo CHAR(1),
    TipoSangre VARCHAR(5)
);
GO
------------------
CREATE TABLE ProcedimientoMedico (
    IdProcedimiento INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Costo DECIMAL(10,2) NOT NULL,
    Tipo VARCHAR(30) CHECK (Tipo IN ('Cirugía','Hospitalización','Consulta')),
    DuracionEstimada INT -- minutos
);
GO
---------------
CREATE TABLE AtencionMedica (
    IdAtencion INT IDENTITY(1,1) PRIMARY KEY,
    IdPaciente INT NOT NULL,
    FechaAtencion DATETIME NOT NULL,
    TipoAtencion VARCHAR(50),
    Total DECIMAL(10,2),
    Estado VARCHAR(30), 
    FOREIGN KEY (IdPaciente) REFERENCES Paciente(IdPaciente)
);
GO
-----------------
CREATE TABLE DetalleAtencionMedica (
    IdDetalleAtencion INT IDENTITY(1,1) PRIMARY KEY,
    IdAtencion INT,
    IdProcedimiento INT,
    Observacion VARCHAR(255),
    FOREIGN KEY (IdAtencion) REFERENCES AtencionMedica(IdAtencion),
    FOREIGN KEY (IdProcedimiento) REFERENCES ProcedimientoMedico(IdProcedimiento)
);
GO
------------
CREATE TABLE AreaClinica (
    IdArea INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    Ubicacion VARCHAR(200)
);
GO
------------------
CREATE TABLE UsoInsumoProcedimiento (
    IdUso INT IDENTITY(1,1) PRIMARY KEY,
    IdProcedimiento INT,
    IdInsumo INT,
    CantidadNecesaria DECIMAL(10,4),
    FOREIGN KEY (IdProcedimiento) REFERENCES ProcedimientoMedico(IdProcedimiento),
    FOREIGN KEY (IdInsumo) REFERENCES InsumoMedico(IdInsumo),
    CONSTRAINT UQ_Uso UNIQUE (IdProcedimiento, IdInsumo)
);
GO
---------------
