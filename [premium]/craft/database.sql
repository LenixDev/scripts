CREATE TABLE IF NOT EXISTS crafting_queue (
    id INT(11) NOT NULL AUTO_INCREMENT,
    user VARCHAR(100) NOT NULL,
    name VARCHAR(64) NOT NULL,
    label VARCHAR(64) NOT NULL,
    count INT(11) NOT NULL,
    duration INT(11) NOT NULL,
    image TEXT,
    ingredients JSON,
    propModel VARCHAR(64),
    price INT(11) NOT NULL,
    canItBeCraftable BOOLEAN DEFAULT 0,
    status ENUM("in_progress", "completed") NOT NULL DEFAULT "in_progress",
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1;
