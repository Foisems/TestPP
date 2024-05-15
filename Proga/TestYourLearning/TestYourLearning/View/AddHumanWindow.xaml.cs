using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using TestYourLearning.Model;

namespace TestYourLearning.View
{
    /// <summary>
    /// Логика взаимодействия для AddHumanWindow.xaml
    /// </summary>
    public partial class AddHumanWindow : Window
    {
        private bool isTeacher = false;
        public AddHumanWindow(int? IdHuman, bool IsTeacher)
        {
            InitializeComponent();

            isTeacher = IsTeacher;

            ComboTeacher.ItemsSource = TestDBEntities.GetContext().Subject.ToList();
            ComboGroup.ItemsSource = TestDBEntities.GetContext().Group.ToList();

            if (IsTeacher)
            {
                ComboTeacher.Visibility = Visibility.Visible;
                ComboGroup.Visibility = Visibility.Collapsed;
                this.Title = "Добавить преподавателя";
                titleLabel.Content = "Добавить преподавателя";
                labelSubject.Content = "Предмет:";
            }
            else
            {
                ComboTeacher.Visibility = Visibility.Collapsed;
                ComboGroup.Visibility = Visibility.Visible;
                this.Title = "Добавить студента";
                titleLabel.Content = "Добавить студента";
                labelSubject.Content = "Группа:";
            }
        }

        // Добваление Human User
        private void addHumanBtn_Click(object sender, RoutedEventArgs e)
        {
            var newHuman = new Human();
            var newUser = new User();

            newUser.IdImage = 1;

            bool firstnameL = firstNameTB.Text.Length > 0 && firstNameTB.Text.Trim().Length != 0;
            bool surnameL = surnameTB.Text.Length > 0 && surnameTB.Text.Trim().Length != 0;
            bool loginL = loginTB.Text.Length > 0 && loginTB.Text.Trim().Length != 0;
            bool passwordL = passwordTB.Text.Length > 0 && passwordTB.Text.Trim().Length != 0;

            if (!surnameL)
            {
                MessageBox.Show("Введите фамилию", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newHuman.Surname = surnameTB.Text;
            }
            if (!firstnameL)
            {
                MessageBox.Show("Введите имя", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newHuman.FirstName = firstNameTB.Text;
            }
            if (!loginL)
            {
                MessageBox.Show("Введите логин", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newUser.Login = loginTB.Text;
            }
            if (!passwordL)
            {
                MessageBox.Show("Введите пароль", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newUser.Password = passwordTB.Text;
            }

            newHuman.Patronymic = patronymicTB.Text;

            if (isTeacher)
            {
                if (ComboTeacher.Text == null || ComboTeacher.Text == "")
                {
                    MessageBox.Show("Выберите предмет", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    Subject subject = (Subject)ComboTeacher.Items[ComboTeacher.SelectedIndex];
                    newHuman.IdSubject = subject.Id;

                    newUser.IdRole = 2;
                }
            }
            else
            {
                if (ComboGroup.Text == null || ComboGroup.Text == "")
                {
                    MessageBox.Show("Выберите группу", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    Group group = (Group)ComboGroup.Items[ComboGroup.SelectedIndex];
                    newHuman.IdGroup = group.Id;

                    newUser.IdRole = 3;
                }
            }
           
            if (newHuman.Surname != null && newHuman.FirstName != null && (newHuman.IdSubject != null || newHuman.IdGroup != null) && newUser.Login != null && newUser.Password != null)
            {
                using (TestDBEntities db = new TestDBEntities())
                {
                    db.Human.AddOrUpdate(newHuman);
                    db.User.AddOrUpdate(newUser);
                    db.SaveChanges();
                }
                this.Close();
            }
        }
    }
}
