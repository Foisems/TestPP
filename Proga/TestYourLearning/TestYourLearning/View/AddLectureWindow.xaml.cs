using Microsoft.Win32;
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
    /// Логика взаимодействия для AddLectureWindow.xaml
    /// </summary>
    public partial class AddLectureWindow : Window
    {
        private int idSubject = 0;
        private bool isAdd = true;
        private int? idLecture = null;
        public AddLectureWindow(int IdSubject, int? IdLecture, bool IsAdd)
        {
            InitializeComponent();
            idSubject = IdSubject;
            isAdd = IsAdd;
            idLecture = IdLecture;

            if (IsAdd)
            {
                this.Title = "Добавить лекцию";
                titleLabel.Content = "Добавить лекцию";
                addLectureBtn.Content = "Добавить";
            }
            // Редактировать лекцию
            else
            {
                this.Title = "Редактировать лекцию";
                titleLabel.Content = "Редактировать лекцию";
                addLectureBtn.Content = "Редактирвоать";
                using (TestDBEntities db = new TestDBEntities())
                {
                    nameLectureTB.Text = db.Lecture.FirstOrDefault(u => u.Id == idLecture).Name;
                    pathLectureTB.Text = db.Lecture.FirstOrDefault(u => u.Id == idLecture).Lecture1;
                }
            }
        }

        // Добавить путь в TextBox
        private void addPathBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Title = "Select a lecture";
            ofd.Filter = "PDF |*.pdf";
            if (ofd.ShowDialog() == true)
            {
                pathLectureTB.Text = ofd.FileName;
            }
        }

        // Добавить лекцию
        private void addLectureBtn_Click(object sender, RoutedEventArgs e)
        {
            var newLecture = new Lecture();
            newLecture.IdSubject = idSubject;
            if(idLecture != null)
            {
                newLecture.Id = (int)idLecture;
            }
            

            bool nameL = nameLectureTB.Text.Length > 0 && nameLectureTB.Text.Trim().Length != 0;
            bool pathL = pathLectureTB.Text.Length > 0 && pathLectureTB.Text.Trim().Length != 0;

            if (!nameL)
            {
                MessageBox.Show("Введите название лекции", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newLecture.Name = nameLectureTB.Text;
            }
            if (!pathL)
            {
                MessageBox.Show("Выберите/введите путь лекции", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newLecture.Lecture1 = pathLectureTB.Text;
            }            
           
            if (newLecture.Name != null && newLecture.Lecture1 != null)
            {
                using (TestDBEntities db = new TestDBEntities())
                {
                    db.Lecture.AddOrUpdate(newLecture);
                    db.SaveChanges();
                }
                this.Close();

            }
        }
    }
}
