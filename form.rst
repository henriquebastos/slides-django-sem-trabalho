Validação de Formulários
------------------------------

* Validação em Javascript é por UX.
* Validação de backend é para segurança.
* Elas se complementam, mas uma não substitui a outra.

Desacople o estilo do Form
--------------------------

.. class:: small, gray

``template.html``

.. container:: tiny

    .. sourcecode:: html+django

        <style>
            .css-unico-deste-input {...}
        </style>
        <form>
            {{ form.as_p }}
        </form>

.. class:: small, gray

``forms.py``

.. container:: tiny

    .. sourcecode:: python

        class Tweet(forms.Form):
            msg = forms.CharField(widget=forms.TextInput(attrs={'class': 'css-unico-deste-input'}))

.. class:: small, gray

``output``

.. container:: tiny

    .. sourcecode:: html

        <form>
            <p>
                <label for="id_msg">Msg:</label>
                <input type="text" id="id_msg" name="msg" class="css-unico-deste-input" />
            </p>
        </form>

Desacople o estilo do Form
--------------------------

.. class:: small, gray

``template.html``

.. container:: tiny

    .. sourcecode:: html+django

        <style>
            .css-unico-deste-input input {...}
        </style>
        <form>
            {{ form.non_field_errors }}

            <div class="css-unico-deste-input">
                <label for="{{ form.msg.id_for_label }}">{{ form.msg.label }}:</label>
                {{ form.msg }}
                {{ form.msg.errors }}
            </div>
        </form>

.. class:: small, gray

``forms.py``

.. container:: tiny

    .. sourcecode:: python

        class Tweet(forms.Form):
            msg = forms.CharField()

.. class:: small, gray

``output``

.. container:: tiny

    .. sourcecode:: html

        <form>
            <div class="css-unico-deste-input">
                <label for="id_msg">Msg:</label>
                <input type="text" id="id_msg" name="msg" />
            </div>
        </form>

Cuidado com o ModelForm
-----------------------

.. sourcecode:: python

    # models.py
    class Matricula(models.Model):
        nome = models.CharField(max_length=255)
        cpf = models.CharField(max_length=11)

.. sourcecode:: python

    # forms.py
    class MatriculaForm(forms.ModelForm):
        class Meta:
            model = Matricula

Cuidado com o ModelForm
-----------------------

.. sourcecode:: python

    # models.py
    class Matricula(models.Model):
        nome = models.CharField(max_length=255)
        cpf = models.CharField(max_length=11)
        pago = models.BooleanField()

.. sourcecode:: python

    # forms.py
    class MatriculaForm(forms.ModelForm):
        class Meta:
            model = Matricula


Cuidado com o ModelForm
-----------------------

.. sourcecode:: python

    # models.py
    class Matricula(models.Model):
        nome = models.CharField(max_length=255)
        cpf = models.CharField(max_length=11)
        pago = models.BooleanField()

.. sourcecode:: python

    # forms.py
    class MatriculaForm(forms.ModelForm):
        class Meta:
            model = Matricula
            exclude = ('pago',)

Cuidado com o ModelForm
-----------------------

.. sourcecode:: python

    # models.py
    class Matricula(models.Model):
        nome = models.CharField(max_length=255)
        cpf = models.CharField(max_length=11)
        pago = models.BooleanField()

.. sourcecode:: python

    # forms.py
    class MatriculaForm(forms.ModelForm):
        class Meta:
            model = Matricula
            fields = ('nome', 'cpf')
