.. image:: https://raw.githubusercontent.com/lab-ml/lab/master/images/lab_logo.png
   :width: 150
   :alt: Logo
   :align: center

.. image:: https://badge.fury.io/py/labml.svg
    :target: https://badge.fury.io/py/labml
.. image:: https://pepy.tech/badge/labml
    :target: https://pepy.tech/project/labml

.. image:: https://img.shields.io/badge/slack-chat-green.svg?logo=slack
    :target: https://join.slack.com/t/labforml/shared_invite/zt-egj9zvq9-Dl3hhZqobexgT7aVKnD14g/

.. image:: https://img.shields.io/twitter/follow/labmlai?style=social
    :target: https://twitter.com/labmlai?ref_src=twsrc%5Etfw

labml.ai
========

Organize machine learning experiments and monitor training progress and hardware usage from mobile

.. image:: https://github.com/lab-ml/lab/raw/master/images/cover.png
   :alt: Mobile view

🔥 Features
-----------

* Monitor running experiments from `mobile phone <https://github.com/lab-ml/app>`_ |sample_experiment|

* Monitor `hardware usage on any computer <https://github.com/lab-ml/labml/blob/master/guides/hardware_monitoring.md>`_ with a single command

* Integrate with just 2 lines of code (see examples below)

* Keeps track of experiments including information like git commit, configurations and hyper-parameters

* Keep Tensorboard logs organized

* `Dashboard <https://github.com/lab-ml/dashboard/>`_ to locally browse and manage experiment runs

* Save and load checkpoints

* API for custom visualizations |analytics_colab1| |analytics_colab2|

* Pretty logs of training progress

* Open source! we also have a small hosted server for the mobile web app

.. |sample_experiment| image:: https://img.shields.io/badge/labml-experiment-brightgreen
    :target: https://app.labml.ai/run/9e7f39e047e811ebbaff2b26e3148b3d

.. |analytics_colab1| image:: https://colab.research.google.com/assets/colab-badge.svg
    :target: https://colab.research.google.com/github/lab-ml/samples/blob/master/labml_samples/pytorch/stocks/analysis.ipynb
.. |analytics_colab2| image:: https://colab.research.google.com/assets/colab-badge.svg
    :target: https://colab.research.google.com/github/vpj/poker/blob/master/kuhn_cfr/kuhn_cfr.ipynb)


Installation
^^^^^^^^^^^^^^^

You can install this package using PIP.

.. code-block:: console

    pip install labml


PyTorch example
^^^^^^^^^^^^^^^

.. code-block:: python

    from labml import tracker, experiment

    with experiment.record(name='sample', exp_conf=conf):
        for i in range(50):
            loss, accuracy = train()
            tracker.save(i, {'loss': loss, 'accuracy': accuracy})

TensorFlow 2.0 Keras example
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

    from labml import experiment
    from labml.utils.keras import LabMLKerasCallback

    with experiment.record(name='sample', exp_conf=conf):
        for i in range(50):
            model.fit(x_train, y_train, epochs=conf['epochs'], validation_data=(x_test, y_test),
                      callbacks=[LabMLKerasCallback()], verbose=None)

PyTorch Lightning example
^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

    from labml import experiment
    from labml.utils.lightning import LabMLLightningLogger

    trainer = pl.Trainer(gpus=1, max_epochs=5, progress_bar_refresh_rate=20, logger=LabMLLightningLogger())

    with experiment.record(name='sample', exp_conf=conf, disable_screen=True):
        trainer.fit(model, data_loader)

`Monitoring hardware usage <https://github.com/lab-ml/labml/blob/master/guides/hardware_monitoring.md>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: console

    pip install labml psutil py3nvml
    labml monitor