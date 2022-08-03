# API - BookStore

**Endpoints** (Click to go there):

| Create                                            | Index                                     | Show                                                        | Update                                         | Delete                                         |
| ------------------------------------------------- | ----------------------------------------- | ----------------------------------------------------------- | ---------------------------------------------- | ---------------------------------------------- |
| [Registering authors](#registering-authors)       | [Listing books](#listing-books)           | [View details of a book](#view-details-of-a-book)           | [Updating a book](#updating-a-book)           | [Deleting a book](#deleting-a-book)           |
| [Registering publishers](#registering-publishers) | [Listing authors](#listing-authors)       | [View details of a author](#view-details-of-a-author)       | [Updating a author](#updating-a-author)       | [Deleting a author](#deleting-a-author)       |
| [Registering books](#registering-books)           | [Listing publishers](#listing-publishers) | [View details of a publisher](#view-details-of-a-publisher) | [Updating a publisher](#updating-a-publisher) | [Deleting a publisher](#deleting-a-publisher) |

# Registering authors

## Request: ![POST](https://img.shields.io/badge/-POST-grenn "POST")![/authors](https://img.shields.io/badge/-/authors-grey "/authors")

### Success response

#### Request body

```json
{ "name": "Neil Gaiman" }
```

#### Response body

```json
{
  "id": 1,
  "name": "Neil Gaiman",
  "created_at": "2022-07-26T20:42:54.140Z",
  "updated_at": "2022-07-26T20:42:54.140Z"
}
```

**response status:**

```ruby
:created
```

---

### Failure responses

#### Request body

```json
{ "name": "" }
```

#### Response body

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

#### Request body

```json
{ "foo": "bar" }
```

#### Response body

```json
{
  "message": "param is missing or the value is empty: author"
}
```

**response status:**

```ruby
:bad_request
```

# Registering publishers

## Request: ![POST](https://img.shields.io/badge/-POST-grenn "POST")![/publishers](https://img.shields.io/badge/-/publishers-grey "/publishers")

### Success response

#### Request body

```json
{ "name": "Intrínseca" }
```

#### Response body

```json
{
  "id": 1,
  "name": "Intrínseca",
  "created_at": "2022-07-26T20:42:54.140Z",
  "updated_at": "2022-07-26T20:42:54.140Z"
}
```

**response status:**

```ruby
:created
```

---

### Failure responses

#### Request body

```json
{ "name": "" }
```

#### Response body

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

#### Request body

```json
{ "foo": "bar" }
```

#### Response body

```json
{
  "message": "param is missing or the value is empty: publisher"
}
```

**response status:**

```ruby
:bad_request
```

# Registering books

## Request: ![POST](https://img.shields.io/badge/-POST-grenn "POST")![/books](https://img.shields.io/badge/-/books-grey "/books")

### Success response

#### Request body

```json
{
  "title": "Mitologia Nórdica",
  "genre": "Mito",
  "language": "0",
  "edition": "second edition",
  "place": "Brasil",
  "year": 1972,
  "author_id": 1,
  "publisher_id": 1
}
```

#### Response body

```json
{
  "id": 1,
  "title": "Mitologia Nórdica",
  "genre": "Mito",
  "language": "0",
  "edition": "second edition",
  "place": "Brasil",
  "year": 1972,
  "created_at": "2022-07-25T21:35:25.863Z",
  "updated_at": "2022-07-25T21:35:25.863Z",
  "author_id": 1,
  "publisher_id": 1
}
```

**response status:**

```ruby
:created
```

---

### Failure responses

#### Request body

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

#### Response body

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

#### Request body

```json
{ "foo": "bar" }
```

#### Response body

```json
{
  "message": "param is missing or the value is empty: book"
}
```

**response status:**

```ruby
:bad_request
```

# Listing books

## Request: ![GET](https://img.shields.io/badge/-GET-purple "GET")![/books](https://img.shields.io/badge/-/books-grey "/books")

### Success response

#### Request body

```json
{ "page": 1 }
```

**_If page parameters are not specified, the first page will be listed._**

#### Response body

```json
[
  {
    "title": "Mitologia Nórdica",
    "genre": "Mito",
    "language": "0",
    "edition": "second edition",
    "place": "Brasil",
    "year": 1972,
    "author": "Neil Gaiman",
    "publisher": "Intrínseca"
  }
]

```

**response status:**

```ruby
:ok
```

---

#### Request body

```json
{ "page": 2 }
```

Each page displays 5 objects, if there are not enough objects to be displayed on a second page, you will get this answer:

```json
[]
```

**response status:**

```ruby
:ok
```

# Listing authors

## Request: ![GET](https://img.shields.io/badge/-GET-purple "GET")![/authors](https://img.shields.io/badge/-/authors-grey "/authors")

### Success response

#### Request body

```json
{ "page": 1 }
```

**_If page parameters are not specified, the first page will be listed._**

#### Response body

```json
[
  {
    "name": "Neil Gaiman"
  },
  {
    "name": "Hermiston"
  }
]

```

**response status:**

```ruby
:ok
```

---

#### Request body

```json
{ "page": 2 }
```

Each page displays 5 objects, if there are not enough objects to be displayed on a second page, you will get this answer:

```json
[]
```

**response status:**

```ruby
:ok
```

# Listing publishers

## Request: ![GET](https://img.shields.io/badge/-GET-purple "GET")![/publishers](https://img.shields.io/badge/-/publishers-grey "/publishers")

### Success response

#### Request body

```json
{ "page": 1 }
```

**_If page parameters are not specified, the first page will be listed._**

#### Response body

```json
[
  {
    "name": "Intrínseca"
  },
  {
    "name": "Bosco Inc"
  }
]

```

**response status:**

```ruby
:ok
```

#### Request body

```json
{ "page": 2 }
```

Each page displays 5 objects, if there are not enough objects to be displayed on a second page, you will get this answer:

```json
[]
```

**response status:**

```ruby
:ok
```

# View details of a book

## Request: ![GET](https://img.shields.io/badge/-GET-purple "GET")![/books/:id](https://img.shields.io/badge/-/books/:id-grey "/books/:id")

**_Replace the id in the url with the id of the object you want._**

### Success response

#### Response body

```json
{
  "title": "Mitologia Nórdica",
  "genre": "Mito",
  "language": "0",
  "edition": "second edition",
  "place": "Brasil",
  "year": 1972,
  "author": "Neil Gaiman",
  "publisher": "Intrínseca"
}

```

**response status:**

```ruby
:ok
```

---

### Failure responses

If the id provided does not match any registered object you will see something like:

#### Response body

```json
{
  "message": "Couldn't find Book with 'id'=999"
}
```

**response status:**

```ruby
:not_found
```

# View details of a author

## Request: ![GET](https://img.shields.io/badge/-GET-purple "GET")![/authors/:id](https://img.shields.io/badge/-/authors/:id-grey "/authors/:id")

**_Replace the id in the url with the id of the object you want._**

### Success response

#### Response body

```json
{
  "name": "Neil Gaiman"
}

```

**response status:**

```ruby
:ok
```

---

### Failure responses

If the id provided does not match any registered object you will see something like:

#### Response body

```json
{
  "message": "Couldn't find Author with 'id'=999"
}
```

**response status:**

```ruby
:not_found
```

# View details of a publisher

## Request: ![GET](https://img.shields.io/badge/-GET-purple "GET")![/publishers/:id](https://img.shields.io/badge/-/publishers/:id-grey "/publishers/:id")

**_Replace the id in the url with the id of the object you want._**

### Success response

#### Response body

```json
{
  "name": "Intrínseca"
}

```

**response status:**

```ruby
:ok
```

---

### Failure responses

If the id provided does not match any registered object you will see something like:

#### Response body

```json
{
  "message": "Couldn't find Publisher with 'id'=999"
}
```

**response status:**

```ruby
:not_found
```

# Updating a book

## Request: ![PUT](https://img.shields.io/badge/-PUT-orange "PUT")![/books/:id](https://img.shields.io/badge/-/books/:id-grey "/books/:id")

**_Replace the id in the url with the id of the object you want to edit. In the body of the request, type all the keys of the attributes you want to edit and insert the desired value. In this example we are going to change the same object used previously._**

### Success response

#### Request body

```json
{
  "language": "English",
  "place": "EUA"
}
```

#### Response body

`doesn't have a response body`

**response status:**

```ruby
:no_content
```

See the details of this book again, the data must have been updated.

---

### Failure responses

#### Request body

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

#### Response body

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

#### Request body

```json
{ "foo": "bar" }
```

#### Response body

```json
{
  "message": "param is missing or the value is empty: book"
}
```

**response status:**

```ruby
:bad_request
```

# Updating a author

## Request: ![PUT](https://img.shields.io/badge/-PUT-orange "PUT")![/authors/:id](https://img.shields.io/badge/-/authors/:id-grey "/authors/:id")

**_Replace the id in the url with the id of the object you want to edit. In the body of the request, type all the keys of the attributes you want to edit and insert the desired value. In this example we are going to change the same object used previously._**

### Success response

#### Request body

```json
{
  "name": "foo"
}
```

#### Response body

`doesn't have a response body`

**response status:**

```ruby
:no_content
```

See the details of this book again, the data must have been updated.

---

### Failure responses

#### Request body

```json
{ "name": "" }
```

#### Response body

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

#### Request body

```json
{ "foo": "bar" }
```

#### Response body

```json
{
  "message": "param is missing or the value is empty: author"
}
```

**response status:**

```ruby
:bad_request
```

# Updating a publisher

## Request: ![PUT](https://img.shields.io/badge/-PUT-orange "PUT")![/publishers/:id](https://img.shields.io/badge/-/publishers/:id-grey "/publishers/:id")

**_Replace the id in the url with the id of the object you want to edit. In the body of the request, type all the keys of the attributes you want to edit and insert the desired value. In this example we are going to change the same object used previously._**

### Success response

#### Request body

```json
{ "name": "bar" }
```

#### Response body

`doesn't have a response body`

**response status:**

```ruby
:no_content
```

See the details of this book again, the data must have been updated.

---

### Failure responses

#### Request body

```json
{ "name": "" }
```

#### Response body

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

#### Request body

```json
{ "foo": "baz" }
```

#### Response body

```json
{
  "message": "param is missing or the value is empty: publisher"
}
```

**response status:**

```ruby
:bad_request
```

# Deleting a book

## Request: ![DELETE](https://img.shields.io/badge/-DELETE-red "DELETE")![/books/:id](https://img.shields.io/badge/-/books/:id-grey "/books/:id")

**_Replace the id in the URL with the id of the object you want to destroy._**

### Success response

#### Response body

```json
{
  "message": "Mitologia Nórdica was deleted"
}

```

**response status:**

```ruby
:ok
```

---

### Failure responses

If the id provided does not match any registered object you will see something like:

#### Response body

```json
{
  "message": "Couldn't find Book with 'id'=999"
}
```

**response status:**

```ruby
:not_found
```

# Deleting a author

## Request: ![DELETE](https://img.shields.io/badge/-DELETE-red "DELETE")![/authors/:id](https://img.shields.io/badge/-/authors/:id-grey "/authors/:id")

**_Replace the id in the URL with the id of the object you want to destroy._**

### Success response

#### Response body

```json
{
  "message": "foo was deleted"
}

```

**response status:**

```ruby
:ok
```

---

### Failure responses

If the id provided does not match any registered object you will see something like:

#### Response body

```json
{
  "message": "Couldn't find Book with 'id'=999"
}
```

**response status:**

```ruby
:not_found
```

# Deleting a publisher

## Request: ![DELETE](https://img.shields.io/badge/-DELETE-red "DELETE")![/publishers/:id](https://img.shields.io/badge/-/publishers/:id-grey "/publishers/:id")

**_Replace the id in the URL with the id of the object you want to destroy._**

### Success response

#### Response body

```json
{
  "message": "bar was deleted"
}

```

**response status:**

```ruby
:ok
```

---

### Failure responses

If the id provided does not match any registered object you will see something like:

#### Response body

```json
{
  "message": "Couldn't find Book with 'id'=999"
}
```

**response status:**

```ruby
:not_found
```
