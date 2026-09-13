CREATE DATABASE IF NOT EXISTS sistema_crud
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sistema_crud;

CREATE TABLE IF NOT EXISTS transacoes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NULL,
    recorrencia_id INT UNSIGNED NULL,
    tipo ENUM('receita', 'despesa', 'diario') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    data_transacao DATE NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_transacoes_usuario_data (user_id, data_transacao),
    CONSTRAINT chk_transacoes_valor CHECK (valor > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS recorrencias (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    tipo ENUM('receita', 'despesa', 'diario') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    ativa TINYINT(1) NOT NULL DEFAULT 1,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_recorrencias_usuario (user_id, ativa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;