CREATE TABLE IF NOT EXISTS exercise (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS set_entry (
    id INTEGER PRIMARY KEY,
    exercise_id INTEGER NOT NULL,
    reps INTEGER NOT NULL,
    weight INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id)
);