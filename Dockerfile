FROM jekyll/jekyll:latest

ENV JEKYLL_VERSION "3.8"

EXPOSE 4000


# docker run --rm \
#   --volume="$PWD:/srv/jekyll:Z" \
#   --publish [::1]:4000:4000 \
#   jekyll/jekyll \
#   jekyll serve