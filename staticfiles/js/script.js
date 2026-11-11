
    const toggleBtn = document.querySelector('.sidebar-toggle');
    const sidebar = document.querySelector('.main-nav');
    const mainContent = document.querySelector('.main-container');

    toggleBtn?.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        if (sidebar.classList.contains('collapsed')) {
            sidebar.style.width = '60px';
            mainContent.style.marginLeft = '60px';
        } else {
            sidebar.style.width = '220px';
            mainContent.style.marginLeft = '220px';
        }
    });


    $(document).ready(function() {
        var rfidInput = $('#rfid-input');
        var submitButton = $('#submit-rfid');
        var messageElement = $('#rfid-message');

        // Handle RFID scan input
        rfidInput.on('input', function() {
            var rfidValue = rfidInput.val().trim();

            // Enable submit button if RFID is not empty
            if (rfidValue.length > 0) {
                submitButton.prop('disabled', false);
            } else {
                submitButton.prop('disabled', true);
            }
        });

        // Handle RFID submit
        submitButton.on('click', function() {
            var rfid = rfidInput.val().trim();

            if (rfid.length > 0) {
                // Send the RFID to the server to fetch the latest attendance
                $.ajax({
                    url: '{% url "latest_attendance" %}',
                    type: 'GET',
                    data: {
                        rfid: rfid
                    },
                    success: function(data) {
                        if (data.found) {
                            messageElement.html('<p>Scan Successful!</p>');
                            // Optionally update the latest attendance on the dashboard
                            $('#latest-attendance').html(
                                '<p><strong>Student:</strong> ' + data.student + '</p>' +
                                '<p><strong>Student ID:</strong> ' + data.student_id + '</p>' +
                                '<p><strong>Subject:</strong> ' + data.subject + '</p>' +
                                '<p><strong>Status:</strong> ' + data.status + '</p>' +
                                '<p><strong>Time:</strong> ' + data.time + '</p>' +
                                '<p><strong>Date:</strong> ' + data.date + '</p>'
                            );
                        } else {
                            messageElement.html('<p>No record found for this RFID card.</p>');
                        }
                    },
                    error: function() {
                        messageElement.html('<p>Error fetching data. Please try again.</p>');
                    }
                });
            } else {
                messageElement.html('<p>Please scan a valid RFID card.</p>');
            }
        });
    });


    document.getElementById('rfid-input').addEventListener('input', function() {
        var rfid = this.value.trim();

        if (rfid) {
            // Send an AJAX request to get the latest attendance record
            fetch(`/dashboard_or_attendance/?rfid=${rfid}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.found) {
                    // Display attendance information
                    document.getElementById('latest-attendance').innerHTML = `
                        <p><strong>Student:</strong> ${data.student}</p>
                        <p><strong>Subject:</strong> ${data.subject}</p>
                        <p><strong>Status:</strong> ${data.status}</p>
                        <p><strong>Date:</strong> ${data.date}</p>
                        <p><strong>Time:</strong> ${data.time}</p>
                    `;
                } else {
                    document.getElementById('latest-attendance').innerHTML = `
                        <p>No attendance record found for this student.</p>
                    `;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('latest-attendance').innerHTML = `<p>Error fetching data. Please try again later.</p>`;
            });
        } else {
            document.getElementById('latest-attendance').innerHTML = `<p>Loading...</p>`;
        }
    });
