from django import forms

USERNAME_FIELD_MAX_LENGTH = 75
PASSWORD_FIELD_MAX_LENGTH = 75


class Login(forms.Form):
    """Managers admin panel login form."""

    username = forms.CharField(
        label='Логин',
        max_length=USERNAME_FIELD_MAX_LENGTH,
        required=True,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Укажите имя пользователя'}),
    )
    password = forms.CharField(
        label='Пароль',
        max_length=PASSWORD_FIELD_MAX_LENGTH,
        required=True,
        widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': 'Введите пароль'}),
    )
