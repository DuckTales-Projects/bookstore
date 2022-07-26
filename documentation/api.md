# API - BookStore

# Registering authors

![POST](https://img.shields.io/badge/-POST-blue "POST")![/authors](https://img.shields.io/badge/-/authors-grey "/authors")

## Success response

### Request body

```json
{ "name": "author_name" }
```

### Response body

```json
{
  "id": 1,
  "name": "author_name",
  "created_at": "2022-07-26T20:42:54.140Z",
  "updated_at": "2022-07-26T20:42:54.140Z"
}
```

**response status:**

```ruby
:created
```

---

## Failure responses

### Request body

```json
{ "name": "" }
```

### Response body

```json
{
  "message": "Validation failed: Name can't be blank, Name is too short (minimum is 3 characters)"
}
```

**response status:**

```ruby
:unprocessable_entity
```

---

### Request body

```json
{ "foo": "bar" }
```

### Response body

```json
{
  "message": "param is missing or the value is empty: author"
}
```

**response status:**

```ruby
:bad_request
```

---

# Registering publishers

![POST](https://img.shields.io/badge/-POST-blue "POST")![/publishers](https://img.shields.io/badge/-/publishers-grey "/publishers")

## Success response

### Request body

```json
{ "name": "publisher_name" }
```

### Response body

```json
{
  "id": 1,
  "name": "publisher_name",
  "created_at": "2022-07-26T20:42:54.140Z",
  "updated_at": "2022-07-26T20:42:54.140Z"
}
```

**response status:**

```ruby
:created
```

---

## Failure responses

### Request body

```json
{ "name": "" }
```

### Response body

```json
{
  "message": "Validation failed: Name can't be blank, Name is too short (minimum is 5 characters)"
}
```

**response status:**

```ruby
:unprocessable_entity
```

---

### Request body

```json
{ "foo": "bar" }
```

### Response body

```json
{
  "message": "param is missing or the value is empty: publisher"
}
```

**response status:**

```ruby
:bad_request
```

---

# Registering books

![POST](https://img.shields.io/badge/-POST-blue "POST")![/books](https://img.shields.io/badge/-/books-grey "/books")

## Success response

### Request body

```json
{
  "title": "book_name",
  "genre": "book_genre",
  "language": "book_language",
  "edition": "book_edition",
  "place": "book_place",
  "year": 2022,
  "author_id": 1,
  "publisher_id": 1
}
```

### Response body

```json
{
  "id": 1,
  "title": "book_name",
  "genre": "book_genre",
  "language": "book_language",
  "edition": "book_edition",
  "place": "book_place",
  "year": 2022,
  "created_at": "2022-07-26T20:42:37.471Z",
  "updated_at": "2022-07-26T20:42:37.471Z",
  "author_id": 1,
  "publisher_id": 1
}
```

**response status:**

```ruby
:created
```

---

## Failure responses

### Request body

```json
{
  "title": "",
  "genre": "",
  "language": "",
  "edition": "",
  "place": "",
  "year": null,
  "author_id": null,
  "publisher_id": null
}
```

### Response body

```json
{
  "message": "Validation failed: Author must exist, Publisher must exist, Year is not a number, Year can't be blank, Language can't be blank, Title can't be blank, Genre can't be blank, Edition can't be blank, Place can't be blank, Title is too short (minimum is 2 characters), Genre is too short (minimum is 2 characters), Edition is too short (minimum is 2 characters), Place is too short (minimum is 2 characters)"
}
```

**response status:**

```ruby
:unprocessable_entity
```

---

### Request body

```json
{ "foo": "bar" }
```

### Response body

```json
{
  "message": "param is missing or the value is empty: book"
}
```

**response status:**

```ruby
:bad_request
```
