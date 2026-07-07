-- UiTM PTAR eLibrary System SQL Schema
-- Sourced directly from erd.png

CREATE DATABASE IF NOT EXISTS elibrary_db;
USE elibrary_db;

-- 1. Table: LIBRARIAN
CREATE TABLE IF NOT EXISTS LIBRARIAN (
    librarian_id VARCHAR(50) NOT NULL,
    supervisor_id VARCHAR(50) NULL,
    librarian_name VARCHAR(100) NOT NULL,
    librarian_email VARCHAR(100) NOT NULL UNIQUE,
    librarian_password VARCHAR(255) NOT NULL,
    librarian_phone VARCHAR(20) NULL,
    position VARCHAR(50) NULL,
    PRIMARY KEY (librarian_id),
    CONSTRAINT fk_librarian_supervisor FOREIGN KEY (supervisor_id) 
        REFERENCES LIBRARIAN(librarian_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Table: BOOK
CREATE TABLE IF NOT EXISTS BOOK (
    book_id VARCHAR(50) NOT NULL,
    librarian_id VARCHAR(50) NOT NULL,
    book_title VARCHAR(255) NOT NULL,
    author_name VARCHAR(100) NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    publish_year VARCHAR(10) NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    book_status VARCHAR(50) NOT NULL,
    book_type VARCHAR(20) NOT NULL, -- Discriminator: 'E-BOOK' or 'PHYSICAL_BOOK'
    PRIMARY KEY (book_id),
    CONSTRAINT fk_book_librarian FOREIGN KEY (librarian_id) 
        REFERENCES LIBRARIAN(librarian_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Table: E_BOOK (Subclass of BOOK)
CREATE TABLE IF NOT EXISTS E_BOOK (
    book_id VARCHAR(50) NOT NULL,
    file_size VARCHAR(50) NOT NULL,
    access_link VARCHAR(255) NOT NULL,
    PRIMARY KEY (book_id),
    CONSTRAINT fk_ebook_book FOREIGN KEY (book_id) 
        REFERENCES BOOK(book_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Table: PHYSICAL_BOOK (Subclass of BOOK)
CREATE TABLE IF NOT EXISTS PHYSICAL_BOOK (
    book_id VARCHAR(50) NOT NULL,
    shelf_location VARCHAR(100) NOT NULL,
    accession_no VARCHAR(50) NOT NULL,
    copy_number INT NOT NULL,
    condition_status VARCHAR(100) NOT NULL,
    PRIMARY KEY (book_id),
    CONSTRAINT fk_physical_book FOREIGN KEY (book_id) 
        REFERENCES BOOK(book_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Table: BORROWER
CREATE TABLE IF NOT EXISTS BORROWER (
    borrower_id VARCHAR(50) NOT NULL,
    borrower_name VARCHAR(100) NOT NULL,
    borrower_email VARCHAR(100) NOT NULL UNIQUE,
    borrower_password VARCHAR(255) NOT NULL,
    borrower_phone VARCHAR(20) NULL,
    borrower_type VARCHAR(50) NOT NULL,
    borrower_status VARCHAR(50) NOT NULL,
    PRIMARY KEY (borrower_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Table: BORROW
CREATE TABLE IF NOT EXISTS BORROW (
    borrow_id VARCHAR(50) NOT NULL,
    borrower_id VARCHAR(50) NOT NULL,
    librarian_id VARCHAR(50) NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    borrow_status VARCHAR(50) NOT NULL,
    PRIMARY KEY (borrow_id),
    CONSTRAINT fk_borrow_borrower FOREIGN KEY (borrower_id) 
        REFERENCES BORROWER(borrower_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_borrow_librarian FOREIGN KEY (librarian_id) 
        REFERENCES LIBRARIAN(librarian_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Table: BORROWING_DETAIL (Associative Entity)
CREATE TABLE IF NOT EXISTS BORROWING_DETAIL (
    borrow_id VARCHAR(50) NOT NULL,
    book_id VARCHAR(50) NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NULL,
    detail_status VARCHAR(50) NOT NULL,
    PRIMARY KEY (borrow_id, book_id),
    CONSTRAINT fk_detail_borrow FOREIGN KEY (borrow_id) 
        REFERENCES BORROW(borrow_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detail_book FOREIGN KEY (book_id) 
        REFERENCES BOOK(book_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
