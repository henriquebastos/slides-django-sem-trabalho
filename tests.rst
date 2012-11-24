Testes
------

* Organize seus testes em packages.
* Use uma asserção por método de teste.
* Não se limite ao que o ``unittest`` e o ``Django`` oferecem.
* Implemente as suas asserções.


``TestCases`` = Cenários de Testes
----------------------------------

* Não se engane com a conta de 1 TestCase por ``classe``;
* Use um TestCase para cada contexto;
* Não herde um TestCase de outro criando mágicas;
* Mas quando um ``setUp`` grande se repetir, reaproveite.

Use o django-nose com rednose
-----------------------------

* pip install django-nose rednose

.. container:: small

    .. sourcecode:: python

        # settings.py

        TEST_RUNNER = 'django_nose.NoseTestSuiteRunner'
        NOSE_ARGS = [
            '--match=^(must|ensure|should|test|it_should)',
            '--where=%s' % PROJECT_DIR,
            '--id-file=%s' % PROJECT_DIR.child('.noseids'),
            '--all-modules',
            '--with-id',
            '--verbosity=2',
            '--nologcapture',
            '--rednose',
        ]

Verifique a estrutura do seu Html
---------------------------------

.. container:: center, huge

    .. image:: assets/form.png

Verifique a estrutura do seu Html
---------------------------------

.. container:: small

    .. sourcecode:: python

        class SubscribeTest(TestCase):
            def setUp(self):
                self.resp = self.client.get(r('subscriptions:subscribe'))

            def test_html(self):
                'Html must contain input controls.'
                self.assertContains(self.resp, '<form')
                self.assertContains(self.resp, '<input', 6)
                self.assertContains(self.resp, 'type="text"', 4)
                self.assertContains(self.resp, 'type="submit"')

Mommy make it!
--------------

* Fixtures como initial data é ok.
* Fixtures montar um cenário de testes é ruim.
* `ModelMommy <https://github.com/vandersonmota/model_mommy>`_ do `Argentino <https://github.com/vandersonmota>`_ #ftw

.. container:: small

    .. sourcecode:: python

        from django.test import TestCase
        from model_mommy import mommy
        from project.app.models import Kid

        class MyTest(TestCase):
            def setUp(self):
                self.kid = mommy.make_one(Kid)

Teste de Plugable Apps
----------------------

.. container:: tiny

    .. sourcecode:: python

        #!/usr/bin/env python
        # runtests.py
        import sys
        from django.conf import settings

        if not settings.configured:
            settings.configure(
                DATABASES={
                    'default': {
                        'ENGINE': 'django.db.backends.sqlite3',
                        'NAME': ':memory:',
                    }
                },
                INSTALLED_APPS=(
                    'something', # Don't forget dependencies
                ),
                SECRET_KEY='something-secret',
                SITE_ID=1,
                ROOT_URLCONF='something.tests.urls', # If needed
            )

        from django.test.utils import get_runner

        def runtests():
            TestRunner = get_runner(settings)
            test_runner = TestRunner(verbosity=1, interactive=True, failfast=False)
            sys.exit(test_runner.run_tests(['something', ]))

        if __name__ == '__main__':
            runtests()
