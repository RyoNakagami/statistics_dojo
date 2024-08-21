FROM rocker/verse:4.4

LABEL maintainer="RyoNak"

ARG USERNAME=rstudio
ARG GROUPNAME=rstudio
ARG UID=1000
ARG GID=1000

# Install apt packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     libxt-dev \
     libxml2-dev \
     libgit2-dev \
     libfontconfig1-dev \
     curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN chown rstudio:rstudio -R /home/rstudio

RUN Rscript -e 'install.packages("renv")'
RUN mkdir /home/rstudio/custom_script
COPY ./docker_script /home/rstudio/custom_script

# permission
RUN cd /home/rstudio && mkdir -p .TinyTeX workspaces .cache/R && \
    chown -R $UID:$GID .TinyTeX && \
    chown -R $UID:$GID .cache/R && \
    chown -R $UID:$GID .cache

# add sudoer unless you cant use quarto
RUN adduser rstudio sudo

EXPOSE 4200

# PATH
ENV PATH="$PATH:/home/rstudio/custom_script"

USER $USERNAME