namespace MyApp
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
			this.components = new System.ComponentModel.Container();
			this.groupBox2 = new System.Windows.Forms.GroupBox();
			this.lblMainAppDomian = new System.Windows.Forms.TextBox();
			this.txtReverseData = new System.Windows.Forms.TextBox();
			this.btnCalculate = new System.Windows.Forms.Button();
			this.txtReturnedData = new System.Windows.Forms.TextBox();
			this.btnGetValue = new System.Windows.Forms.Button();
			this.lblCurrentAssembly = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.lblCurrentAppDomain = new System.Windows.Forms.Label();
			this.label1 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.radioAssembly2 = new System.Windows.Forms.RadioButton();
			this.radioAssembly1 = new System.Windows.Forms.RadioButton();
			this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
			this.groupBox2.SuspendLayout();
			this.groupBox1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
			this.SuspendLayout();
			// 
			// groupBox2
			// 
			this.groupBox2.Controls.Add(this.lblMainAppDomian);
			this.groupBox2.Controls.Add(this.txtReverseData);
			this.groupBox2.Controls.Add(this.btnCalculate);
			this.groupBox2.Controls.Add(this.txtReturnedData);
			this.groupBox2.Controls.Add(this.btnGetValue);
			this.groupBox2.Controls.Add(this.lblCurrentAssembly);
			this.groupBox2.Controls.Add(this.label2);
			this.groupBox2.Controls.Add(this.lblCurrentAppDomain);
			this.groupBox2.Controls.Add(this.label1);
			this.groupBox2.Controls.Add(this.label4);
			this.groupBox2.Controls.Add(this.label5);
			this.groupBox2.Controls.Add(this.label3);
			this.groupBox2.Location = new System.Drawing.Point(12, 68);
			this.groupBox2.Name = "groupBox2";
			this.groupBox2.Size = new System.Drawing.Size(299, 196);
			this.groupBox2.TabIndex = 4;
			this.groupBox2.TabStop = false;
			this.groupBox2.Text = "Actions";
			// 
			// lblMainAppDomian
			// 
			this.lblMainAppDomian.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.lblMainAppDomian.Location = new System.Drawing.Point(142, 70);
			this.lblMainAppDomian.Name = "lblMainAppDomian";
			this.lblMainAppDomian.ReadOnly = true;
			this.lblMainAppDomian.Size = new System.Drawing.Size(149, 13);
			this.lblMainAppDomian.TabIndex = 3;
			this.lblMainAppDomian.Text = "Default AppDomain";
			// 
			// txtReverseData
			// 
			this.txtReverseData.Location = new System.Drawing.Point(12, 115);
			this.txtReverseData.Name = "txtReverseData";
			this.txtReverseData.Size = new System.Drawing.Size(136, 20);
			this.txtReverseData.TabIndex = 2;
			this.txtReverseData.Text = "String Data to be inversed";
			// 
			// btnCalculate
			// 
			this.btnCalculate.Location = new System.Drawing.Point(188, 115);
			this.btnCalculate.Name = "btnCalculate";
			this.btnCalculate.Size = new System.Drawing.Size(84, 22);
			this.btnCalculate.TabIndex = 1;
			this.btnCalculate.Text = "Reverse";
			this.btnCalculate.UseVisualStyleBackColor = true;
			this.btnCalculate.Click += new System.EventHandler(this.btnCalculate_Click);
			// 
			// txtReturnedData
			// 
			this.txtReturnedData.Location = new System.Drawing.Point(12, 155);
			this.txtReturnedData.Name = "txtReturnedData";
			this.txtReturnedData.Size = new System.Drawing.Size(136, 20);
			this.txtReturnedData.TabIndex = 2;
			// 
			// btnGetValue
			// 
			this.btnGetValue.Location = new System.Drawing.Point(188, 155);
			this.btnGetValue.Name = "btnGetValue";
			this.btnGetValue.Size = new System.Drawing.Size(84, 22);
			this.btnGetValue.TabIndex = 1;
			this.btnGetValue.Text = "Get Value";
			this.btnGetValue.UseVisualStyleBackColor = true;
			this.btnGetValue.Click += new System.EventHandler(this.btnGetValue_Click);
			// 
			// lblCurrentAssembly
			// 
			this.lblCurrentAssembly.Location = new System.Drawing.Point(139, 23);
			this.lblCurrentAssembly.Name = "lblCurrentAssembly";
			this.lblCurrentAssembly.Size = new System.Drawing.Size(140, 21);
			this.lblCurrentAssembly.TabIndex = 0;
			this.lblCurrentAssembly.Text = "Current Assembly";
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(12, 99);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(77, 13);
			this.label2.TabIndex = 0;
			this.label2.Text = "Data && Results";
			// 
			// lblCurrentAppDomain
			// 
			this.lblCurrentAppDomain.Location = new System.Drawing.Point(139, 46);
			this.lblCurrentAppDomain.Name = "lblCurrentAppDomain";
			this.lblCurrentAppDomain.Size = new System.Drawing.Size(130, 21);
			this.lblCurrentAppDomain.TabIndex = 0;
			this.lblCurrentAppDomain.Text = "Current Appdomain";
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 139);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(77, 13);
			this.label1.TabIndex = 0;
			this.label1.Text = "Data Returned";
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.label4.Location = new System.Drawing.Point(12, 23);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(108, 13);
			this.label4.TabIndex = 0;
			this.label4.Text = "Current Assembly:";
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.label5.Location = new System.Drawing.Point(12, 68);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(106, 13);
			this.label5.TabIndex = 0;
			this.label5.Text = "Main AppDomain:";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.label3.Location = new System.Drawing.Point(12, 46);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(120, 13);
			this.label3.TabIndex = 0;
			this.label3.Text = "Current AppDomain:";
			// 
			// groupBox1
			// 
			this.groupBox1.Controls.Add(this.radioAssembly2);
			this.groupBox1.Controls.Add(this.radioAssembly1);
			this.groupBox1.Location = new System.Drawing.Point(12, 12);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(299, 50);
			this.groupBox1.TabIndex = 6;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = "Select The Assembly File to Load";
			// 
			// radioAssembly2
			// 
			this.radioAssembly2.AutoSize = true;
			this.radioAssembly2.Location = new System.Drawing.Point(155, 19);
			this.radioAssembly2.Name = "radioAssembly2";
			this.radioAssembly2.Size = new System.Drawing.Size(124, 17);
			this.radioAssembly2.TabIndex = 0;
			this.radioAssembly2.Text = "Load Assembly V 2.0";
			this.radioAssembly2.UseVisualStyleBackColor = true;
			this.radioAssembly2.Click += new System.EventHandler(this.LoadAssemblyVersion2);
			// 
			// radioAssembly1
			// 
			this.radioAssembly1.AutoSize = true;
			this.radioAssembly1.Checked = true;
			this.radioAssembly1.Location = new System.Drawing.Point(12, 19);
			this.radioAssembly1.Name = "radioAssembly1";
			this.radioAssembly1.Size = new System.Drawing.Size(124, 17);
			this.radioAssembly1.TabIndex = 0;
			this.radioAssembly1.TabStop = true;
			this.radioAssembly1.Text = "Load Assembly V 1.0";
			this.radioAssembly1.UseVisualStyleBackColor = true;
			this.radioAssembly1.Click += new System.EventHandler(this.LoadAssemblyVersion1);
			// 
			// errorProvider1
			// 
			this.errorProvider1.ContainerControl = this;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(323, 278);
			this.Controls.Add(this.groupBox1);
			this.Controls.Add(this.groupBox2);
			this.Name = "Form1";
			this.Text = "Upgrading .Net Assembly in use without Stopping the application";
			this.Load += new System.EventHandler(this.Form1_Load);
			this.groupBox2.ResumeLayout(false);
			this.groupBox2.PerformLayout();
			this.groupBox1.ResumeLayout(false);
			this.groupBox1.PerformLayout();
			((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
			this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label lblCurrentAppDomain;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblCurrentAssembly;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnGetValue;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton radioAssembly2;
        private System.Windows.Forms.RadioButton radioAssembly1;
		private System.Windows.Forms.TextBox txtReturnedData;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox txtReverseData;
		private System.Windows.Forms.Button btnCalculate;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox lblMainAppDomian;
        private System.Windows.Forms.ErrorProvider errorProvider1;
    }
}

