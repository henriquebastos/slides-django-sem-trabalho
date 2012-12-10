All Settings are different
--------------------------

* Configurações de código: ``INSTALLED_APPS``
* Configurações da instância: ``EMAIL_HOST``


Ideal é ter *1* settings.py para *N* instâncias do projeto.

* `12 factors <http://www.12factor.net/>`_

Settings do Ambiente
--------------------

.. container:: small

    .. sourcecode:: python

        import os

        EMAIL_HOST = os.environ.get('EMAIL_HOST', 'localhost')
        EMAIL_HOST_USER = os.environ.get('EMAIL_HOST_USER', '')
        EMAIL_HOST_PASSWORD = os.environ.get('EMAIL_HOST_PASSWORD', '')

Settings no mundo real
----------------------

::

    repositorio/
        project/
            settings/
                __init__.py
                development.py
                production.py
                stage.py

Settings no mundo real
----------------------

.. container:: small

    .. sourcecode:: bash

        cd repositorio/project

        # Transforme o settings em um package.
        mkdir settings
        touch settings/__init__.py

        # Crie o settings de produção.
        mv settings.py settings/production.py

        # Crie os outros settings derivando do produção.
        echo "from production import *" > settings/{stage,development}.py

Não use diretórios hardcoded
----------------------------

* pip install unipath

.. container:: small

  .. sourcecode:: python

      # settings.py

      from unipath import Path

      PROJECT_DIR = Path(__file__).parent

      STATIC_ROOT = PROJECT_DIR.child('public')
      MEDIA_ROOT = PROJECT_DIR.child('media')

Settings com valores padrões
----------------------------

.. container:: small

    * Use o `django-appconf <http://pypi.python.org/pypi/django-appconf>`_

    .. sourcecode:: python

        # paypal/conf.py
        from appconf import AppConf

        class PaypalConf(AppConf):
            TEST = False
            POSTBACK_ENDPOINT = "https://www.paypal.com/cgi-bin/webscr"

            #...

            class Meta:
                prefix = 'paypal'
                holder = 'paypal.conf.settings'

Settings com valores padrões
----------------------------

.. container:: small

    * Como fica na view?

    .. sourcecode:: python

        # paypal/views.py
        from django.http import HttpResponse
        from paypal.conf import settings

        def someview(request):
            text = 'Endpoint is: %s' % settings.PAYPAL_POSTBACK_ENDPOINT
            return HttpResponse(text)
