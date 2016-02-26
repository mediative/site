# YPG Data Site Sources

## Setup

Setting up the local site:

 - Install the `hugo` site generator: `brew install hugo`
 - Update theme git submodule: `make setup`

## Add you author information

 - Copy existing config file: `cp data/authors/{fonseca,$USER}.yml`
 - Change the fields to match your profile:

```yaml
name: John Doe
bio: Writing software that eats the world
location: Montreal, Canada
website: https://github.com/john-doe
thumbnail: "images/authors/john-doe.jpg"
```

## Adding content

 - `hugo new post/my-new-post.md` - Create new post.
 - `$EDITOR post/my-new-post.md` - Edit post.
 - `hugo` or `make site` - Generate static content into `public/`.
 - `hugo server` - Start server to automatically regenerate content.
