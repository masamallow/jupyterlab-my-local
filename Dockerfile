# jupyter/scipy-notebook
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook
FROM quay.io/jupyter/scipy-notebook:python-3.11

USER root

RUN set -ex \
	&& apt update \
	&& apt upgrade -y \
	&& apt install -y tzdata \
	&& apt autoclean -y \
	&& apt autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Set time zone
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER jovyan

RUN pip install --upgrade pip wheel setuptools
RUN conda update -n base -c conda-forge conda \
	&& conda update --all -y \
	&& conda clean -i -t -y

# Not japanize-matplotlib but matplotlib-fontja
# because japanize-matplotlib does not work with Python 3.12 or later and `conda install` does not work even with Python 3.11 or before.
# https://github.com/ciffelia/matplotlib-fontja
RUN conda install conda-forge::matplotlib-fontja
