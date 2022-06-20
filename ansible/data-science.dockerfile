FROM jupyter/pyspark-notebook:b9f6ce795cfc

RUN pip install --upgrade \
    jupyterlab==3.2.0 \
    jupyterlab-git==0.33.0 \
    papermill==2.3.3
